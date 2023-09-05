//
//  LoginCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/02.
//

import UIKit

class LoginVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        navigationController.present(loginViewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
}
