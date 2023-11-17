//
//  ProductDetailViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/04.
//

import Foundation
import Combine


protocol ProductDetailViewModelInput {
    func fetchDescription()
}

protocol ProductDetailViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var cocktailDescriptionPublisher: Published< CocktailDescription?>.Publisher { get }
}

typealias ProductDetailViewModel = ProductDetailViewModelInput & ProductDetailViewModelOutput

final class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let cocktailDetailRepository: CocktailDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var cocktailDescription: CocktailDescription?
    
    //MARK: - Init
    init(cocktailDetailRepository: CocktailDetailRepository) {
        self.cocktailDetailRepository = cocktailDetailRepository
    }
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    //MARK: - Input
    func fetchDescription() {
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
                }
            ).store(in: &cancelBag)
    }
}
