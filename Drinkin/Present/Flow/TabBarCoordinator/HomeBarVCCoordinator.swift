//
//  HomeBarVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class HomeBarVCCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
    }
    
    func startPush() -> UINavigationController {
        let myHomeBarDIContainer = MyHomeBarDIContainer()
        
        let homeBarViewController = HomeBarViewController(viewModel: myHomeBarDIContainer.makeMyHomeBarViewModel())
 
        navigationController.setViewControllers([homeBarViewController], animated: false)
        
        return navigationController
    }
}

