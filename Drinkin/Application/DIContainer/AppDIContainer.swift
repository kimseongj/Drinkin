//
//  AppDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

final class AppDIContainer {
    let keyChainManager = KeychainManager()
    let provider = Provider()
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        return TriedCocktailSelectionDIContainer()
    }
    
    func makeCocktailRecommendDIContainer() -> CocktailRecommendDIContainer {
        return CocktailRecommendDIContainer()
    }
    
    func makeProductDetailDIContainer() -> ProductDetailDIContainer {
        return ProductDetailDIContainer()
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        return CocktailFilterDICotainer()
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        return MyHomeBarDIContainer()
    }
    
    func makeLoginSettingDIContainer() -> LoginSettingDIContainer {
        return LoginSettingDIContainer()
    }
    
    func makeAddIngredientDIContainer() -> AddIngredientDIContainer {
        return AddIngredientDIContainer()
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        return SavedCocktailListDIContainer()
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        return UserMadeCocktailListDIContainer()
    }
}
