//
//  MainVCCorrdinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/11.


import UIKit

protocol MainVCFlow: AnyObject {
    func presentLoginVC()
    func pushTriedCocktailSelectionVC()
    func pushProductDetailVC(cocktailID: Int)
}

class MainVCCoordinator: Coordinator, MainVCFlow {
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    
    func start() { }
    
    func startPush() -> UINavigationController {
        let cocktailRecommendDIContainer = appDIContainer.makeCocktailRecommendDIContainer()
        let mainViewController = MainViewController(viewModel: cocktailRecommendDIContainer.makeCocktailRecommendViewModel())
        
        mainViewController.makeBlackBackBarButton()
        mainViewController.flowDelegate = self
        navigationController.setViewControllers([mainViewController], animated: false)
        
        return navigationController
    }
    
    func presentLoginVC() {
        let loginVCCoordinator = LoginVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        loginVCCoordinator.start()
    }
    
    func pushTriedCocktailSelectionVC() {
        let triedCocktailSelectionViewCoordinator = TriedCocktailSelectionVCCoordinator(navigationController: navigationController,
                                                                                        appDIContainer: appDIContainer)
        triedCocktailSelectionViewCoordinator.start()
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
