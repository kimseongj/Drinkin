//
//  MyHomeBarVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

protocol HomeBarVCDelegate: AnyObject {
    func pushSavedCocktailListVC()
    func pushUserMadeCocktailListVC()
}

class HomeBarVCCoordinator: Coordinator, HomeBarVCDelegate {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() { }
    
    func childDidFinish(_ child: Coordinator?) { }
    
    func startPush() -> UINavigationController {
        let myHomeBarDIContainer = MyHomeBarDIContainer()
        
        let myHomeBarViewController = MyHomeBarViewController(viewModel: myHomeBarDIContainer.makeMyHomeBarViewModel())
        myHomeBarViewController.delegate = self
        navigationController.setViewControllers([myHomeBarViewController], animated: false)
        
        return navigationController
    }
    
    func pushSavedCocktailListVC() {
        let savedCocktailListVCCoordinator = SavedCocktailListVCCoordinator(navigationController: navigationController)
        savedCocktailListVCCoordinator.start()
    }
    
    func pushUserMadeCocktailListVC() {
        let userMadeCocktailListVCCoordinator = UserMadeCocktailListVCCoordinator(navigationController: navigationController)
        userMadeCocktailListVCCoordinator.start()
    }
}
