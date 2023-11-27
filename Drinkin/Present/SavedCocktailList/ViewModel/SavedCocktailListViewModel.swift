//
//  SavedCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol SavedCocktailListViewModelInput {
    func fetchCocktailPreviewDescription(completion: @escaping () -> Void)
}

protocol SavedCocktailListViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }
}

typealias SavedCocktailListViewModel = SavedCocktailListViewModelInput & SavedCocktailListViewModelOutput

final class DefaultSavedCocktailListViewModel: SavedCocktailListViewModel {
    private let savedCocktailListRepository: SavedCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var previewDescriptionList: [CocktailPreview] = []
    
    //MARK: - Init
    init(savedCocktailListRepository: SavedCocktailListRepository) {
        self.savedCocktailListRepository = savedCocktailListRepository
    }
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    //MARK: - Input
    func fetchCocktailPreviewDescription(completion: @escaping () -> Void) {
        savedCocktailListRepository.fetchSavedCocktailList()
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
                    guard let self = self else { return}
                    self.previewDescriptionList = $0.cocktailList
                    completion()
                }
            ).store(in: &cancelBag)
    }
}
