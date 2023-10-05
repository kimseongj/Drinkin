//
//  AddIngredientVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit

class AddIngredientVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let addIngredientDIContainer = appDIContainer.makeAddIngredientDIContainer()
        let vc = addIngredientDIContainer.makeAddIngredientViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
