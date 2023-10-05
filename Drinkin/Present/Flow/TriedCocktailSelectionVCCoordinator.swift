//
//  TriedCocktailSelectionVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

protocol TriedCocktailSelectionVCDelegate: AnyObject {
    func presentLoginVC()
    func didFinishTriedCocktailSelectionVC()
}

class TriedCocktailSelectionVCCoordinator: Coordinator, TriedCocktailSelectionVCDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var triedCocktailSelectionViewController: TriedCocktailSelectionViewController?
    let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let triedCocktailSelectionDIContainer = appDIContainer.makeTriedCocktailSelectionDIContainer()
        let vc = triedCocktailSelectionDIContainer.makeTriedCocktailSelectionViewController()
        
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
        triedCocktailSelectionViewController = vc
    }
    
    func presentLoginVC() {
        let vc = LoginViewController()
        
        vc.modalPresentationStyle = .fullScreen
        triedCocktailSelectionViewController?.present(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishTriedCocktailSelectionVC() {
        
    }
}
