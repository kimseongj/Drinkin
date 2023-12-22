//
//  UserMadeCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/09.
//

import UIKit

protocol UserMadeCocktailListVCFlow {
    func pushProductDetailVC(cocktailID: Int, syncUserMadeCocktailDelegate: SyncUserMadeCocktailDelegate?)
}

class UserMadeCocktailListVCCoordinator: Coordinator, UserMadeCocktailListVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let userMadeCocktailListDIContainer = appDIContainer.makeUserMadeCocktailListDIContainer()
        let userMadeCocktailListViewController = userMadeCocktailListDIContainer.makeUserMadeCocktailListViewController()
        userMadeCocktailListViewController.flowDelegate = self
        userMadeCocktailListViewController.makeBlackBackBarButton()
        
        navigationController.pushViewController(userMadeCocktailListViewController, animated: true)
    }
    
    func pushProductDetailVC(cocktailID: Int, syncUserMadeCocktailDelegate: SyncUserMadeCocktailDelegate?) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID,
                                                                    syncUserMadeCocktailDelegate: syncUserMadeCocktailDelegate)
        productDetailVCCoordinator.start()
    }
}
