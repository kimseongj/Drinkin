//
//  UserMadeCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListViewModelInput {
    func fetchCocktailPreviewDescription()
}

protocol UserMadeCocktailListViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }
}

typealias UserMadeCocktailListViewModel = UserMadeCocktailListViewModelInput & UserMadeCocktailListViewModelOutput

final class DefaultUserMadeCocktailListViewModel: UserMadeCocktailListViewModel {
    private let userMadeCocktailListRepository: UserMadeCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var previewDescriptionList: [CocktailPreview] = []
    
    //MARK: - Init
    init(userMadeCocktailListRepository: UserMadeCocktailListRepository) {
        self.userMadeCocktailListRepository = userMadeCocktailListRepository
    }
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    //MARK: - Input
    func fetchCocktailPreviewDescription() {
        userMadeCocktailListRepository.fetchUserMadeCocktailList()
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        switch error {
                        case .unauthorized:
                            self.errorType = .unauthorized
                        case .notFound:
                            self.errorType = .notFound
                        case .networkError(_):
                            self.errorType = .networkError(error)
                        case .decodingError:
                            self.errorType = .decodingError
                        case .refreshTokenExpired:
                            self.errorType = .refreshTokenExpired
                        case .noError:
                            break
                        }
                    case .finished:
                        return
                    }
                },
                receiveValue: { [weak self] in
                    guard let self = self else { return }
                    
                    self.previewDescriptionList = $0.cocktailList
                }
            ).store(in: &cancelBag)
    }
}
