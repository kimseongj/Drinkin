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
        return DefaultDescriptionRepository(tokenManager: dependencies.tokenManager,
                                            provider: dependencies.provider,
                                            endpoint: productDetailEndpoint,
                                            cocktailID: cocktailID)
    }
    
    func makeFetchCocktailDescriptionUsecase(cocktailID: Int) -> FetchCocktailDescriptionUsecase {
        return DefaultFetchCocktailDescriptionUsecase(cocktailDescriptionRepository: makeCocktailDescriptionRepository(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewModel(cocktailID: Int) -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(fetchCocktailDescriptionUseCase: makeFetchCocktailDescriptionUsecase(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        return ProductDetailViewController(viewModel: viewModel)
    }
}
