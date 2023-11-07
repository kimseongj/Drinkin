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
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    func start() { }
    
    func startPush() -> UINavigationController {
        let myHomeBarDIContainer = appDIContainer.makeMyHomeBarDIContainer()
        let myHomeBarViewController = myHomeBarDIContainer.makeMyHomeBarViewController()
        
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
        let addIngredientVCCoordinator = AddIngredientVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        addIngredientVCCoordinator.start()
    }
    
    func pushSavedCocktailListVC() {
        let savedCocktailListVCCoordinator = SavedCocktailListVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        savedCocktailListVCCoordinator.start()
    }
    
    func pushUserMadeCocktailListVC() {
        let userMadeCocktailListVCCoordinator = UserMadeCocktailListVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        userMadeCocktailListVCCoordinator.start()
    }
}

