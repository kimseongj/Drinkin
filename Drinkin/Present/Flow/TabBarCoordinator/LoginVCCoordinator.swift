//
//  LoginVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/02.
//

import UIKit

protocol LoginVCFlow {
    func presentTriedCocktailSelectionVC()
}

class LoginVCCoordinator: Coordinator, LoginVCFlow {
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let loginDIContainer = appDIContainer.makeLoginDIContainer()
        
        let loginViewController = loginDIContainer.makeLoginViewController()
        loginViewController.flowDelegate = self
        loginViewController.modalPresentationStyle = .fullScreen
        navigationController.present(loginViewController, animated: true)
    }
    
    func presentTriedCocktailSelectionVC() {
        let triedCocktailSelectionViewCoordinator = TriedCocktailSelectionVCCoordinator(navigationController: navigationController,
                                                                                        appDIContainer: appDIContainer)
        triedCocktailSelectionViewCoordinator.start()
    }
}
