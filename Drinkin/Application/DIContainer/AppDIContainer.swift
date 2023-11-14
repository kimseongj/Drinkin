//
//  AppDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

final class AppDIContainer {
    private lazy var provider = DefaultProvider()
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        TriedCocktailSelectionDIContainer(provider: provider)
    }
    
    func makeCocktailRecommendDIContainer() -> CocktailRecommendDIContainer {
        CocktailRecommendDIContainer(provider: provider)
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
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        CocktailFilterDICotainer(provider: provider)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        MyHomeBarDIContainer(provider: provider)
    }
    
    func makeLoginDIContainer() -> LoginDIContainer {
        LoginDIContainer(provider: provider)
    }
    
    func makeLoginSettingDIContainer() -> LoginSettingDIContainer {
        LoginSettingDIContainer(provider: provider)
    }
    
    func makeAddItemDIContainer() -> AddItemDIContainer {
        AddItemDIContainer(provider: provider)
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        SavedCocktailListDIContainer(provider: provider)
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        UserMadeCocktailListDIContainer(provider: provider)
    }
}
