//
//  SavedCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/08.
//

import UIKit

protocol SavedCocktailListVCFlow {
    func pushProductDetailVC(cocktailID: Int)
}

class SavedCocktailListVCCoordinator: Coordinator, SavedCocktailListVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let savedCocktailListDIContainer = appDIContainer.makeSavedCocktailListDIContainer()
        let savedCocktailListViewController = savedCocktailListDIContainer.makeSavedCocktailListViewController()
        savedCocktailListViewController.flowDelegate = self
        savedCocktailListViewController.makeBlackBackBarButton()
        
        navigationController.pushViewController(savedCocktailListViewController, animated: true)
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
