//
//  SavedCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/08.
//

import UIKit

class SavedCocktailListVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let savedCocktailListDIContainer = appDIContainer.makeSavedCocktailListDIContainer()
        let vc = savedCocktailListDIContainer.makeSavedCocktailListViewController()
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
