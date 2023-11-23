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
    
    init(provider: Provider, loginProvider: LoginProvider) {
        self.provider = provider
        self.loginProvider = loginProvider
    }
    
    func makeMainDIContainer() -> MainDIContainer {
        MainDIContainer(provider: provider)
    }
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        TriedCocktailSelectionDIContainer(provider: provider)
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        CocktailFilterDICotainer(provider: provider)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        MyHomeBarDIContainer(provider: provider)
    }
    
    func makeProductDetailDIContainer(cocktailID: Int) -> ProductDetailDIContainer {
        ProductDetailDIContainer(provider: provider, cocktailID: cocktailID)
    }
    
    func makeBaseInformationDIContainer(baseID: Int) -> BaseInformationDIContainer {
        BaseInformationDIContainer(provider: provider, baseID: baseID)
    }
    
    func makeBaseBrandInformationDIContainer(brandID: Int) -> BaseBrandInformationDIContainer {
        BaseBrandInformationDIContainer(provider: provider, brandID: brandID)
    }
    
    func makeMakeableCocktailListDIContainer(brandID: Int) -> MakeableCocktailListDIContainer {
        MakeableCocktailListDIContainer(provider: provider, brandID: brandID)
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
