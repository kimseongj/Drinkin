//
//  CocktailFilterVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class CocktailFilterVCCoordinator: Coordinator {
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
        
        filterViewController.makeBlackBackBarButton()
        navigationController.setViewControllers([filterViewController], animated: false)
        
        return navigationController
    }
}
