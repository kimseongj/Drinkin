//
//  LoginVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/02.
//

import UIKit

protocol LoginFlowDelegate {
    func presentTriedCocktailSelectionVC()
}

class LoginVCCoordinator: Coordinator, LoginFlowDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let loginDIContainer = appDIContainer.makeLoginDIContainer()
        
        let loginViewController = loginDIContainer.makeLoginViewController()
        loginViewController.delegate = self
        loginViewController.modalPresentationStyle = .fullScreen
        navigationController.present(loginViewController, animated: true)
    }
    
    func presentTriedCocktailSelectionVC() {
        let triedCocktailSelectionViewCoordinator = TriedCocktailSelectionVCCoordinator(navigationController: navigationController,
                                                                                        appDIContainer: appDIContainer)
        triedCocktailSelectionViewCoordinator.parentCoordinator = self
        childCoordinators.append(triedCocktailSelectionViewCoordinator)
        triedCocktailSelectionViewCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) { }
    
    func didFinsihLoginVC() {
        
    }
}
