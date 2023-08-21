//
//  MainVCCorrdinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/11.


import UIKit

class MainVCCoordinator: Coordinator, MainViewDelegate {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() {
    }
    
    func startPush() -> UINavigationController {
        let cocktailRecommendDIContainer = DIContainer()
        
        let mainViewController = MainViewController(viewModel: cocktailRecommendDIContainer.makeCocktailRecommendViewModel())
        mainViewController.delegate = self
        navigationController.setViewControllers([mainViewController], animated: false)
        
        return navigationController
    }
    
    func pushChooseCocktailVC() {
        let preferCocktailSelectionViewCoordinator = TriedCocktailSelectionViewCoordinator(navigationController: navigationController)
        
        preferCocktailSelectionViewCoordinator.parentCoordinator = self
        childCoordinators.append(preferCocktailSelectionViewCoordinator)
        preferCocktailSelectionViewCoordinator.start()
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController, cocktailID: cocktailID)
        
        productDetailVCCoordinator.parentCoordinator = self
        childCoordinators.append(productDetailVCCoordinator)
        productDetailVCCoordinator.start()
    }
}
