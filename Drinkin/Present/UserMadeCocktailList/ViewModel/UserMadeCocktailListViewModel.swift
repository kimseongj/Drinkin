//
//  UserMadeCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListViewModelInput {
    func fetchCocktailList(completion: @escaping () -> Void)
}

protocol UserMadeCocktailListViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var cocktailList: [CocktailPreview] { get }
    var cocktailListPublisher: Published<[CocktailPreview]>.Publisher { get }
}

protocol SyncUserMadeCocktailDelegate {
    func synchronizeCocktails()
}

typealias UserMadeCocktailListViewModel = UserMadeCocktailListViewModelInput & UserMadeCocktailListViewModelOutput & SyncUserMadeCocktailDelegate

final class DefaultUserMadeCocktailListViewModel: UserMadeCocktailListViewModel {
    private let userMadeCocktailListRepository: UserMadeCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var cocktailList: [CocktailPreview] = []
    
    //MARK: - Init
    
    init(userMadeCocktailListRepository: UserMadeCocktailListRepository) {
        self.userMadeCocktailListRepository = userMadeCocktailListRepository
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var cocktailListPublisher: Published<[CocktailPreview]>.Publisher { $cocktailList }
    
    //MARK: - Input
    
    func fetchCocktailList(completion: @escaping () -> Void) {
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
                    self.cocktailList = $0.cocktailList
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    //MARK: - SyncUserMadeCocktailslDelegate
    
    func synchronizeCocktails() {
        fetchCocktailList { }
    }
}
