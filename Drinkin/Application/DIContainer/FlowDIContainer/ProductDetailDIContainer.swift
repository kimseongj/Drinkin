//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
        let cocktailID: Int
    }
    
    let dependencies: Dependencies
    let productDetailEndpoint = CocktailsEndpoint()
    
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCocktailDescriptionRepository() -> CocktailDetailRepository {
        return DefaultCocktailDetailRepository(tokenManager: dependencies.tokenManager,
                                            provider: dependencies.provider,
                                            endpoint: productDetailEndpoint,
                                               cocktailID: dependencies.cocktailID)
    }

    func makeProductDetailViewModel() -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(cocktailDetailRepository: makeCocktailDescriptionRepository())
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        return ProductDetailViewController(viewModel: viewModel)
    }
}
