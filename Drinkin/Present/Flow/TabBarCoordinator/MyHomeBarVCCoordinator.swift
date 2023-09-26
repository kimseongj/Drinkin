//
//  MyHomeBarVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

protocol MyHomeBarVCDelegate: AnyObject {
    func pushLoginSettingVC()
    func pushAddIngredientVC()
    func pushSavedCocktailListVC()
    func pushUserMadeCocktailListVC()
}

class HomeBarVCCoordinator: Coordinator, MyHomeBarVCDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
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
        let myHomeBarDIContainer = MyHomeBarDIContainer()
        let myHomeBarViewController = MyHomeBarViewController(viewModel: myHomeBarDIContainer.makeMyHomeBarViewModel())
        
        myHomeBarViewController.makeBlackBackBarButton()
        myHomeBarViewController.delegate = self
        navigationController.setViewControllers([myHomeBarViewController], animated: false)
        
        return navigationController
    }
    
    func pushLoginSettingVC() {
        let loginSettingVCCoordinator = LoginSettingVCCoordinator(navigationController: navigationController)
        
        loginSettingVCCoordinator.start()
    }
    
    func pushAddIngredientVC() {
        let addIngredientVCCoordinator = AddIngredientVCCoordinator(navigationController: navigationController)
        
        addIngredientVCCoordinator.start()
    }
    
    func pushSavedCocktailListVC() {
        let savedCocktailListVCCoordinator = SavedCocktailListVCCoordinator(navigationController: navigationController)
        
        savedCocktailListVCCoordinator.start()
    }
    
    func pushUserMadeCocktailListVC() {
        let userMadeCocktailListVCCoordinator = UserMadeCocktailListVCCoordinator(navigationController: navigationController)
        
        
        userMadeCocktailListVCCoordinator.start()
    }
}

