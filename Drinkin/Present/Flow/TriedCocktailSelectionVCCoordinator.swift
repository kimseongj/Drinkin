//
//  TriedCocktailSelectionVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.


import UIKit

class TriedCocktailSelectionViewCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let triedCocktailSelectionDIContainer = TriedCocktailSelectionDIContainer()
        
        let vc = TriedCocktailSelectionViewController(viewModel: triedCocktailSelectionDIContainer.makeTriedCocktailSelectionViewModel())
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
}
