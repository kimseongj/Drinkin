//
//  ProductDetailViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/04.
//

import Foundation
import Combine


protocol ProductDetailViewModelInput {
    func fetchDescription(completion: @escaping () -> Void)
    func updateUserMadeCocktail()
    func updateBookmarkCocktail()
}

protocol ProductDetailViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var cocktailDescriptionPublisher: Published< CocktailDescription?>.Publisher { get }
}

typealias ProductDetailViewModel = ProductDetailViewModelInput & ProductDetailViewModelOutput

final class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let cocktailDetailRepository: CocktailDetailRepository
    private let manageMarkingCocktailUsecase: ManageMarkingCocktailUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var cocktailDescription: CocktailDescription?
    
    //MARK: - Init
    
    init(cocktailDetailRepository: CocktailDetailRepository,
         manageMarkingCocktailUsecase: ManageMarkingCocktailUsecase) {
        self.cocktailDetailRepository = cocktailDetailRepository
        self.manageMarkingCocktailUsecase = manageMarkingCocktailUsecase
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    //MARK: - Input
    
    func fetchDescription(completion: @escaping () -> Void) {
        cocktailDetailRepository.fetchCocktailDescription()
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
                    
                    self.cocktailDescription = $0
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    func updateUserMadeCocktail() {
        guard let validcocktailDescription = cocktailDescription else { return }
        manageMarkingCocktailUsecase.updateUserMadeCocktailMark(cocktailID: validcocktailDescription.id)
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
                receiveValue: { print($0) }
            ).store(in: &cancelBag)
    }
    
    func updateBookmarkCocktail() {
        guard let validcocktailDescription = cocktailDescription else { return }
        manageMarkingCocktailUsecase.updateBookmarkCocktailMark(cocktailID: validcocktailDescription.id)
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
                receiveValue: { print($0) }
            ).store(in: &cancelBag)
    }
    
}
