//
//  AppDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

final class AppDIContainer {
    private let provider: Provider
    private let loginProvider: LoginProvider
    private let loginManager: LoginManager
    
    init(provider: Provider, loginProvider: LoginProvider, loginManager: LoginManager) {
        self.provider = provider
        self.loginProvider = loginProvider
        self.loginManager = loginManager
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        MainDIContainer(provider: provider, loginManager: loginManager)
    }
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        TriedCocktailSelectionDIContainer(provider: provider)
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        CocktailFilterDICotainer(provider: provider)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        MyHomeBarDIContainer(provider: provider, loginManager: loginManager)
    }
    
    func makeProductDetailDIContainer(cocktailID: Int) -> ProductDetailDIContainer {
        ProductDetailDIContainer(provider: provider, loginManager: loginManager, cocktailID: cocktailID)
    }
    
    func makeBaseInformationDIContainer(baseID: Int) -> BaseInformationDIContainer {
        BaseInformationDIContainer(provider: provider, baseID: baseID)
    }
    
    func makeBaseBrandInformationDIContainer(brandID: Int) -> BaseBrandInformationDIContainer {
        BaseBrandInformationDIContainer(provider: provider, brandID: brandID)
    }
    
    func makeIngredientInformationDIContainer(ingredientID: Int) -> IngredientInformationDIContainer {
        IngredientInformationDIContainer(provider: provider, ingredientID: ingredientID)
    }
    
    func makeMakeableCocktailListDIContainer(brandID: Int?, ingredientID: Int?) -> MakeableCocktailListDIContainer {
        MakeableCocktailListDIContainer(provider: provider, brandID: brandID, ingredientID: ingredientID)
    }
    
    func makeLoginDIContainer() -> LoginDIContainer {
        LoginDIContainer(loginProvider: loginProvider)
    }
    
    func makeLoginSettingDIContainer() -> LoginSettingDIContainer {
        LoginSettingDIContainer(provider: provider)
    }
    
    func makeItemSelectionDIContainer() -> ItemSelectionDIContainer {
        ItemSelectionDIContainer(provider: provider)
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        SavedCocktailListDIContainer(provider: provider)
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        UserMadeCocktailListDIContainer(provider: provider)
    }
}
