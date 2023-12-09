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
    let syncDataDelegate: SyncDataDelegate
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, syncDataDelegate: SyncDataDelegate) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.syncDataDelegate = syncDataDelegate
    }
    
    func start() {
        let itemSelectionDIContainer = appDIContainer.makeItemSelectionDIContainer()
        let itemSelectionViewController = itemSelectionDIContainer.makeItemSelectionViewController()
        itemSelectionViewController.synchronizationDataDelegate = syncDataDelegate
        
        navigationController.pushViewController(itemSelectionViewController, animated: true)
    }
}
