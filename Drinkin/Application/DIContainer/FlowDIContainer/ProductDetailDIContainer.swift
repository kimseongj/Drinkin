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
        DefaultCocktailDetailRepository(provider: provider,
                                               endpoint: productDetailEndpoint,
                                               cocktailID: cocktailID)
    }
    
    func makeCocktailMarkingRepository() -> CocktailMarkingRepository {
        DefaultCocktailMarkingRepository(provider: provider,
                                         endpoint: productDetailEndpoint)
    }
    
    func makeManageMarkingCocktailUsecase() -> ManageMarkingCocktailUsecase {
        DefaultManageMarkingCocktailUsecase(cocktailMarkingRepository: makeCocktailMarkingRepository())
    }
    
    func makeProductDetailViewModel() -> ProductDetailViewModel {
        DefaultProductDetailViewModel(cocktailDetailRepository: makeCocktailDescriptionRepository(),
                                      manageMarkingCocktailUsecase: makeManageMarkingCocktailUsecase())
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        ProductDetailViewController(viewModel: viewModel)
    }
}
