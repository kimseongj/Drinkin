//
//  AddIngredientVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

class AddIngredientVCCoordinator: Coordinator {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let addItemDIContainer = appDIContainer.makeAddItemDIContainer()
        let addItemViewController = addItemDIContainer.makeAddItemViewController()
        
        navigationController.pushViewController(addItemViewController, animated: true)
    }
}
