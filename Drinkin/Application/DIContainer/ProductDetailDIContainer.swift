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
    }
    
    let dependencies: Dependencies
    let productDetailEndpoint = ProductDetailEndpoint()
    
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCocktailDescriptionRepository(cocktailID: Int) -> CocktailDetailRepository {
        return DefaultCocktailDetailRepository(tokenManager: dependencies.tokenManager,
                                            provider: dependencies.provider,
                                            endpoint: productDetailEndpoint,
                                            cocktailID: cocktailID)
    }

    func makeProductDetailViewModel(cocktailID: Int) -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(cocktailDetailRepository: makeCocktailDescriptionRepository(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        return ProductDetailViewController(viewModel: viewModel)
    }
}
