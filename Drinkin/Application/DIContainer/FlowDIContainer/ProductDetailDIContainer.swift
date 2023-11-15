//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {
    let provider: Provider
    let cocktailID: Int
    let productDetailEndpoint = CocktailsEndpoint()
    
    
    init(provider: Provider, cocktailID: Int) {
        self.provider = provider
        self.cocktailID = cocktailID
    }
    
    func makeCocktailDescriptionRepository() -> CocktailDetailRepository {
        return DefaultCocktailDetailRepository(provider: provider,
                                               endpoint: productDetailEndpoint,
                                               cocktailID: cocktailID)
    }
    
    func makeProductDetailViewModel() -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(cocktailDetailRepository: makeCocktailDescriptionRepository())
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        return ProductDetailViewController(viewModel: viewModel)
    }
}