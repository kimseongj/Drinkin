//
//  MainVCCorrdinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/11.


import UIKit

protocol MainFlowDelegate: AnyObject {
    func presentLoginVC()
    func pushTriedCocktailSelectionVC()
    func pushProductDetailVC(cocktailID: Int)
}

class MainVCCoordinator: Coordinator, MainFlowDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    
    func start() { }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func startPush() -> UINavigationController {
        let cocktailRecommendDIContainer = appDIContainer.makeCocktailRecommendDIContainer()
        let mainViewController = MainViewController(viewModel: cocktailRecommendDIContainer.makeCocktailRecommendViewModel())
        
        mainViewController.makeBlackBackBarButton()
        mainViewController.delegate = self
        navigationController.setViewControllers([mainViewController], animated: false)
        
        return navigationController
    }
    
    func presentLoginVC() {
        let loginVCCoordinator = LoginVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        
        loginVCCoordinator.parentCoordinator = self
        childCoordinators.append(loginVCCoordinator)
        
        loginVCCoordinator.start()
    }
    
    func pushTriedCocktailSelectionVC() {
        let triedCocktailSelectionViewCoordinator = TriedCocktailSelectionVCCoordinator(navigationController: navigationController,
                                                                                        appDIContainer: appDIContainer)
        
        triedCocktailSelectionViewCoordinator.parentCoordinator = self
        childCoordinators.append(triedCocktailSelectionViewCoordinator)
        triedCocktailSelectionViewCoordinator.start()
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.parentCoordinator = self
        childCoordinators.append(productDetailVCCoordinator)
        productDetailVCCoordinator.start()
    }
}
