//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {
    private let provider: Provider
    private let loginManager: LoginManager
    private let cocktailID: Int
    private let productDetailEndpoint = CocktailsEndpoint()
    private let updateUserMadeEndpoint = UpdateMadeCocktailEndpoint()
    private let updateBookmarkEndpoint = UpdateBookmarkCocktailEndpoint()
    
    init(provider: Provider, loginManager: LoginManager, cocktailID: Int) {
        self.provider = provider
        self.loginManager = loginManager
        self.cocktailID = cocktailID
    }
    
    func makeCocktailDescriptionRepository() -> CocktailDetailRepository {
        DefaultCocktailDetailRepository(provider: provider,
                                               endpoint: productDetailEndpoint,
                                               cocktailID: cocktailID)
    }
    
    func makeCocktailMarkingRepository() -> CocktailMarkingRepository {
        DefaultCocktailMarkingRepository(provider: provider,
                                         userMadeEndpoint: updateUserMadeEndpoint,
                                         bookmarkEndpoint: updateBookmarkEndpoint)
    }
    
    func makeManageMarkingCocktailUsecase() -> ManageMarkingCocktailUsecase {
        DefaultManageMarkingCocktailUsecase(cocktailMarkingRepository: makeCocktailMarkingRepository())
    }
    
    func makeProductDetailViewModel() -> ProductDetailViewModel {
        DefaultProductDetailViewModel(cocktailDetailRepository: makeCocktailDescriptionRepository(),
                                      manageMarkingCocktailUsecase: makeManageMarkingCocktailUsecase())
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        ProductDetailViewController(viewModel: viewModel,
                                    loginManager: loginManager)
    }
}
