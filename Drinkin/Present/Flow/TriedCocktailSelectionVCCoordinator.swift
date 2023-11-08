//
//  TriedCocktailSelectionVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

class TriedCocktailSelectionVCCoordinator: Coordinator {
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
        
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
        triedCocktailSelectionViewController = vc
    }
}
