//
//  ProductDetailViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/04.
//

import Foundation
import Combine

protocol ProductDetailViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var cocktailDescriptionPublisher: Published< CocktailDescription?>.Publisher { get }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

protocol ProductDetailViewModelInput {
    func fetchDescription(completion: @escaping () -> Void)
    func updateUserMadeCocktail()
    func updateBookmarkCocktail()
}

typealias ProductDetailViewModel = ProductDetailViewModelOutput & ProductDetailViewModelInput

final class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let cocktailDetailRepository: CocktailDetailRepository
    private let manageMarkingCocktailUsecase: ManageMarkingCocktailUsecase
    private let authenticationManager: AuthenticationManager
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var cocktailDescription: CocktailDescription?
    
    //MARK: - Init
    
    init(cocktailDetailRepository: CocktailDetailRepository,
         manageMarkingCocktailUsecase: ManageMarkingCocktailUsecase,
         authenticationManager: AuthenticationManager) {
        self.cocktailDetailRepository = cocktailDetailRepository
        self.manageMarkingCocktailUsecase = manageMarkingCocktailUsecase
        self.authenticationManager = authenticationManager
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
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
                    self.cocktailDescription?.baseList = $0.baseList.sorted(by: { $0.hold && !$1.hold })
                    self.cocktailDescription?.ingredientList = $0.ingredientList.sorted(by: { $0.hold && !$1.hold })
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
                receiveValue: { _ in
                    
                }
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
                receiveValue: { _ in
                    
                }
            ).store(in: &cancelBag)
    }
}
