//
//  MainVCCorrdinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/11.


import UIKit

protocol MainViewDelegate: AnyObject {
    func pushTriedCocktailSelectionVC()
    func pushProductDetailVC(cocktailID: Int)
}

class MainVCCoordinator: Coordinator, MainViewDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
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
        let cocktailRecommendDIContainer = BriefDescriptionDIContainer()
        let mainViewController = MainViewController(viewModel: cocktailRecommendDIContainer.makeCocktailRecommendViewModel())
        
        mainViewController.makeBlackBackBarButton()
        mainViewController.delegate = self
        navigationController.setViewControllers([mainViewController], animated: false)
        
        return navigationController
    }
    
    func pushTriedCocktailSelectionVC() {
        let triedCocktailSelectionViewCoordinator = TriedCocktailSelectionVCCoordinator(navigationController: navigationController)
        
        triedCocktailSelectionViewCoordinator.parentCoordinator = self
        childCoordinators.append(triedCocktailSelectionViewCoordinator)
        triedCocktailSelectionViewCoordinator.start()
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.parentCoordinator = self
        childCoordinators.append(productDetailVCCoordinator)
        productDetailVCCoordinator.start()
    }
}
