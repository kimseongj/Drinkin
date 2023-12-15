//
//  LoginSettingVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

protocol LoginSettingVCFlow {
    func presentLoginVC()
}

class LoginSettingVCCoordinator: Coordinator, LoginSettingVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let loginSettingDIContainer = appDIContainer.makeLoginSettingDIContainer()
        let loginSettingViewController = loginSettingDIContainer.makeLoginSettingViewController()
        loginSettingViewController.flowDelegate = self
        
        navigationController.pushViewController(loginSettingViewController, animated: true)
    }
    
    func presentLoginVC() {
        let loginVCCoordinator = LoginVCCoordinator(navigationController: navigationController,
                                                    appDIContainer: appDIContainer)
        loginVCCoordinator.start()
    }
}
