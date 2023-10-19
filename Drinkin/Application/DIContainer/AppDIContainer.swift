//
//  AppDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

final class AppDIContainer {
    private lazy var tokenManager = TokenManager()
    private lazy var provider = Provider()
    
    func makeTriedCocktailSelectionDIContainer() -> TriedCocktailSelectionDIContainer {
        let dependencies = TriedCocktailSelectionDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return TriedCocktailSelectionDIContainer(dependencies: dependencies)
    }
    
    func makeCocktailRecommendDIContainer() -> CocktailRecommendDIContainer {
        let dependencies = CocktailRecommendDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return CocktailRecommendDIContainer(dependencies: dependencies)
    }
    
    func makeProductDetailDIContainer() -> ProductDetailDIContainer {
        let dependencies = ProductDetailDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return ProductDetailDIContainer(dependencies: dependencies)
    }
    
    func makeBaseInformationDIContainer() -> BaseInformationDIContainer {
        let dependencies = BaseInformationDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return BaseInformationDIContainer(dependencies: dependencies)
    }
    
    func makeBaseBrandInformationDIContainer(brandID: Int) -> BaseBrandInformationDIContainer {
        let dependecies = BaseBrandInformationDIContainer.Dependencies(tokenManager: tokenManager, provider: provider, brandID: brandID)
        
        return BaseBrandInformationDIContainer(dependencies: dependecies)
    }
    
    func makeCocktailFilterDICotainer() -> CocktailFilterDICotainer {
        let dependencies = CocktailFilterDICotainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return CocktailFilterDICotainer(dependencies: dependencies)
    }
    
    func makeMyHomeBarDIContainer() -> MyHomeBarDIContainer {
        let dependencies = MyHomeBarDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return MyHomeBarDIContainer(dependencies: dependencies)
    }
    
    func makeLoginSettingDIContainer() -> LoginSettingDIContainer {
        let dependencies = LoginSettingDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return LoginSettingDIContainer(dependencies: dependencies)
    }
    
    func makeAddIngredientDIContainer() -> AddIngredientDIContainer {
        let dependencies = AddIngredientDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return AddIngredientDIContainer(dependencies: dependencies)
    }
    
    func makeSavedCocktailListDIContainer() -> SavedCocktailListDIContainer {
        let dependencies = SavedCocktailListDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return SavedCocktailListDIContainer(dependencies: dependencies)
    }
    
    func makeUserMadeCocktailListDIContainer() -> UserMadeCocktailListDIContainer {
        let dependencies = UserMadeCocktailListDIContainer.Dependencies(tokenManager: tokenManager, provider: provider)
        
        return UserMadeCocktailListDIContainer(dependencies: dependencies)
    }
}
