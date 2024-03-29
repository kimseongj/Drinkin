//
//  ProductDetailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

protocol ProductDetailVCFlow: AnyObject {
    func pushBaseInformationVC(baseID: Int)
    func pushIngredientInformationVC(ingredientID: Int)
    func pushToolModalVC(toolID: Int)
    func pushSkillModalVC(skillID: Int)
    func pushGlassModalVC(glassID: Int)
}

class ProductDetailVCCoordinator: Coordinator, ProductDetailVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    var cocktailID: Int
    var syncUserMadeCocktailDelegate: SyncUserMadeCocktailDelegate?
    var syncSavedCocktailDelegate: SyncSavedCocktailDelegate?
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer,
         cocktailID: Int,
         syncUserMadeCocktailDelegate: SyncUserMadeCocktailDelegate? = nil,
         syncSavedCocktailDelegate: SyncSavedCocktailDelegate? = nil) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.cocktailID = cocktailID
        self.syncUserMadeCocktailDelegate = syncUserMadeCocktailDelegate
        self.syncSavedCocktailDelegate = syncSavedCocktailDelegate
    }
    
    func start() {
        let productDetailDIContainer = appDIContainer.makeProductDetailDIContainer(cocktailID: cocktailID)
        let productDetailViewController = productDetailDIContainer.makeProductDetailViewController()
        
        productDetailViewController.flowDelegate = self
        productDetailViewController.cocktailInformationView.toolView.flowDelegate = self
        productDetailViewController.cocktailInformationView.skillView.flowDelegate = self
        productDetailViewController.cocktailInformationView.glassView.flowDelegate = self
        productDetailViewController.syncSavedCocktailDelegate = syncSavedCocktailDelegate
        productDetailViewController.syncUserMadeCocktailDelegate = syncUserMadeCocktailDelegate
        productDetailViewController.makeBlackBackBarButton()
        
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
    
    func pushBaseInformationVC(baseID: Int) {
        let baseInformationVCCoordinator = BaseInformationVCCoordinator(navigationController: navigationController,
                                                                        appDIContainer: appDIContainer,
                                                                        baseID: baseID)
        baseInformationVCCoordinator.start()
    }
    
    func pushIngredientInformationVC(ingredientID: Int) {
        let ingredientInformationVCCoordinator = IngredientInformationVCCoordinator(navigationController: navigationController,
                                                                                    appDIContainer: appDIContainer,
                                                                                    ingredientID: ingredientID)
        ingredientInformationVCCoordinator.start()
    }
    
    func pushToolModalVC(toolID: Int) {
        let toolModalVCCoordinator = ToolModalVCCoordinator(navigationController: navigationController,
                                                            toolID: toolID)
        toolModalVCCoordinator.start()
    }
    
    func pushSkillModalVC(skillID: Int) {
        let buildModalVCCoordinator = SkillModalVCCoordinator(navigationController: navigationController,
                                                              skillID: skillID)
        buildModalVCCoordinator.start()
    }
    
    func pushGlassModalVC(glassID: Int) {
        let glassModalVCCoordinator = GlassModalVCCoordinator(navigationController: navigationController,
                                                              glassID: glassID)
        glassModalVCCoordinator.start()
    }
}
