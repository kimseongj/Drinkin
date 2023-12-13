//
//  LoginSettingVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

class LoginSettingVCCoordinator: Coordinator {
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
        
        navigationController.pushViewController(loginSettingViewController, animated: true)
    }
}
