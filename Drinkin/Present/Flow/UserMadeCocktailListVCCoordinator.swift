//
//  UserMadeCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/09.
//

import UIKit

class UserMadeCocktailListVCCoordinator: Coordinator {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let userMadeCocktailListDIContainer = appDIContainer.makeUserMadeCocktailListDIContainer()
        let userMadeCocktailListViewController = userMadeCocktailListDIContainer.makeUserMadeCocktailListViewController()
        
        navigationController.pushViewController(userMadeCocktailListViewController, animated: true)
    }
}
