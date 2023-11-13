//
//  CocktailFilterVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

protocol CocktailFilterVCFlow: AnyObject {
    func pushProductDetailVCCoordinator(cocktailID: Int)
}

class CocktailFilterVCCoordinator: Coordinator, CocktailFilterVCFlow {
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    
    func start() { }
    
    func startPush() -> UINavigationController {
        let cocktailFilterDIContainer = appDIContainer.makeCocktailFilterDICotainer()
        let filterViewController = cocktailFilterDIContainer.makeCocktailFilterViewController()
        
        filterViewController.flowDelegate = self
        filterViewController.makeBlackBackBarButton()
        navigationController.setViewControllers([filterViewController], animated: false)
        
        return navigationController
    }
    
    func pushProductDetailVCCoordinator(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
