//
//  MyHomeBarVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

protocol MyHomeBarVCFlow: AnyObject {
    func pushLoginSettingVC()
    func pushItemSelectionVC(syncDataDelegate: SyncDataDelegate)
    func pushSavedCocktailListVC()
    func pushUserMadeCocktailListVC()
    func presentLoginVC()
}

class MyHomeBarVCCoordinator: Coordinator, MyHomeBarVCFlow {
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
        myHomeBarViewController.flowDelegate = self
        navigationController.setViewControllers([myHomeBarViewController], animated: false)
        
        return navigationController
    }
    
    func pushLoginSettingVC() {
        let loginSettingVCCoordinator = LoginSettingVCCoordinator(navigationController: navigationController,
                                                                  appDIContainer: appDIContainer)
        loginSettingVCCoordinator.start()
    }
    
    func pushItemSelectionVC(syncDataDelegate: SyncDataDelegate) {
        let itemSelectionVCCoordinator = ItemSelectionVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    syncDataDelegate: syncDataDelegate)
        itemSelectionVCCoordinator.start()
    }
    
    func pushSavedCocktailListVC() {
        let savedCocktailListVCCoordinator = SavedCocktailListVCCoordinator(navigationController: navigationController,
                                                                            appDIContainer: appDIContainer)
        savedCocktailListVCCoordinator.start()
    }
    
    func pushUserMadeCocktailListVC() {
        let userMadeCocktailListVCCoordinator = UserMadeCocktailListVCCoordinator(navigationController: navigationController,
                                                                                  appDIContainer: appDIContainer)
        userMadeCocktailListVCCoordinator.start()
    }
    
    func presentLoginVC() {
        let loginVCCoordinator = LoginVCCoordinator(navigationController: navigationController,
                                                    appDIContainer: appDIContainer)
        loginVCCoordinator.start()
    }
}

