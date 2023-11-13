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
        let addIngredientDIContainer = appDIContainer.makeAddIngredientDIContainer()
        let addIngredientViewController = addIngredientDIContainer.makeAddIngredientViewController()
        
        navigationController.pushViewController(addIngredientViewController, animated: true)
    }
}
