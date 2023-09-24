//
//  CocktailFilterVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class CocktailFilterVCCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init() {
        self.navigationController = .init()
    }
    
    func start() { }
    
    func childDidFinish(_ child: Coordinator?) { }
    
    func startPush() -> UINavigationController {
        let cocktailFilterDIContainer = CocktailFilterDICotainer()
        let filterViewController = CocktailFilterViewController(viewModel: cocktailFilterDIContainer.makeCocktailFilterViewModel())
        filterViewController.makeBlackBackBarButton()
        //cocktailViewController.delegate = self
        navigationController.setViewControllers([filterViewController], animated: false)
        
        return navigationController
    }
}
