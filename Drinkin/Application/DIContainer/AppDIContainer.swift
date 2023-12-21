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
    private let authenticationManager: AuthenticationManager
    private let synchronizationManager: SynchronizationManager
    
    init(provider: Provider,
         loginProvider: LoginProvider,
         authenticationManager: AuthenticationManager,
         synchronizationManager: SynchronizationManager) {
        self.provider = provider
        self.loginProvider = loginProvider
        self.authenticationManager = authenticationManager
        self.synchronizationManager = synchronizationManager
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        MainDIContainer(provider: provider,
                        authenticationManager: authenticationManager,
                        synchronizationManager: synchronizationManager)
    }
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        TriedCocktailSelectionDIContainer(provider: provider,
                                          synchronizationManager: synchronizationManager)
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        CocktailFilterDICotainer(provider: provider,
                                 authenticationManager: authenticationManager)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        MyHomeBarDIContainer(provider: provider,
                             authenticationManager: authenticationManager)
    }
    
    func makeProductDetailDIContainer(cocktailID: Int) -> ProductDetailDIContainer {
        ProductDetailDIContainer(provider: provider, authenticationManager:
                                    authenticationManager, cocktailID: cocktailID)
    }
    
    func makeBaseInformationDIContainer(baseID: Int) -> BaseInformationDIContainer {
        BaseInformationDIContainer(provider: provider,
                                   baseID: baseID)
    }
    
    func makeBaseBrandInformationDIContainer(brandID: Int) -> BaseBrandInformationDIContainer {
        BaseBrandInformationDIContainer(provider: provider,
                                        brandID: brandID)
    }
    
    func makeIngredientInformationDIContainer(ingredientID: Int) -> IngredientInformationDIContainer {
        IngredientInformationDIContainer(provider: provider,
                                         ingredientID: ingredientID)
    }
    
    func makeMakeableCocktailListDIContainer(brandID: Int?, ingredientID: Int?) -> MakeableCocktailListDIContainer {
        MakeableCocktailListDIContainer(provider: provider,
                                        brandID: brandID,
                                        ingredientID: ingredientID)
    }
    
    func makeLoginDIContainer() -> LoginDIContainer {
        LoginDIContainer(loginProvider: loginProvider,
                         authenticationManager: authenticationManager)
    }
    
    func makeItemSelectionDIContainer() -> ItemSelectionDIContainer {
        ItemSelectionDIContainer(provider: provider,
                                 synchronizationManager: synchronizationManager)
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        SavedCocktailListDIContainer(provider: provider)
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        UserMadeCocktailListDIContainer(provider: provider)
    }
}
