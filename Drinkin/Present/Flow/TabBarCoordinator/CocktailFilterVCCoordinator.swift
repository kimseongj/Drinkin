//
//  CocktailFilterVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

protocol CocktailFilterFlowDelegate: AnyObject {
    func pushProductDetailVCCoordinator(cocktailID: Int)
}

class CocktailFilterVCCoordinator: Coordinator, CocktailFilterFlowDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    
    func start() { }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func startPush() -> UINavigationController {
        let cocktailFilterDIContainer = appDIContainer.makeCocktailFilterDICotainer()
        let filterViewController = cocktailFilterDIContainer.makeCocktailFilterViewController()
        
        filterViewController.delegate = self
        filterViewController.makeBlackBackBarButton()
        navigationController.setViewControllers([filterViewController], animated: false)
        
        return navigationController
    }
    
    func pushProductDetailVCCoordinator(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.parentCoordinator = self
        childCoordinators.append(productDetailVCCoordinator)
        productDetailVCCoordinator.start()
    }
}
