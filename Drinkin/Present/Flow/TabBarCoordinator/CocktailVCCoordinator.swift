//
//  CocktailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class CocktailVCCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
    }
    
    func startPush() -> UINavigationController {
        let filterViewController = FilterViewController()
        //cocktailViewController.delegate = self
        navigationController.setViewControllers([filterViewController], animated: false)
        
        return navigationController
    }
}
