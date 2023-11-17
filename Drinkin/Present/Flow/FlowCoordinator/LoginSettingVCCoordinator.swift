//
//  LoginSettingVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

class LoginSettingVCCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        //let loginSettingDIContainer = LoginSettingDIContainer()
        let loginSettingViewController = LoginSettingViewController()
        
        navigationController.pushViewController(loginSettingViewController, animated: true)
    }
}
