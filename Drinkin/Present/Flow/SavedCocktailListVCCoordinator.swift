//
//  SavedCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/08.
//

import UIKit

class SavedCocktailListVCCoordinator: Coordinator {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let savedCocktailListDIContainer = appDIContainer.makeSavedCocktailListDIContainer()
        let savedCocktailListViewController = savedCocktailListDIContainer.makeSavedCocktailListViewController()
        
        navigationController.pushViewController(savedCocktailListViewController, animated: true)
    }
}
