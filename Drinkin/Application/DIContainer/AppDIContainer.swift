//
//  AppDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

final class AppDIContainer {


    private let tokenManager: TokenManager
    private let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        return TriedCocktailSelectionDIContainer(tokenManager: tokenManager,
                                                 provider: provider)
    }
    
    func makeCocktailRecommendDIContainer() -> CocktailRecommendDIContainer {
        return CocktailRecommendDIContainer(tokenManager: tokenManager,
                                            provider: provider)
    }
    
    func makeProductDetailDIContainer() -> ProductDetailDIContainer {
        return ProductDetailDIContainer(tokenManager: tokenManager,
                                        provider: provider)
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        return CocktailFilterDICotainer(tokenManager: tokenManager,
                                        provider: provider)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        return MyHomeBarDIContainer(tokenManager: tokenManager,
                                    provider: provider)
    }
    
    func makeLoginSettingDIContainer() -> LoginSettingDIContainer {
        return LoginSettingDIContainer(tokenManager: tokenManager,
                                       provider: provider)
    }
    
    func makeAddIngredientDIContainer() -> AddIngredientDIContainer {
        return AddIngredientDIContainer(tokenManager: tokenManager,
                                        provider: provider)
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        return SavedCocktailListDIContainer(tokenManager: tokenManager,
                                            provider: provider)
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        return UserMadeCocktailListDIContainer(tokenManager: tokenManager,
                                               provider: provider)
    }
}
