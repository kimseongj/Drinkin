//
//  ItemSelectionVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

class ItemSelectionVCCoordinator: Coordinator {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let itemSelectionDIContainer = appDIContainer.makeItemSelectionDIContainer()
        let itemSelectionViewController = itemSelectionDIContainer.makeItemSelectionViewController()
        
        navigationController.pushViewController(itemSelectionViewController, animated: true)
    }
}
