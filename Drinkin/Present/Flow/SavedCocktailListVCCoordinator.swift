//
//  SavedCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/08.
//

import UIKit

class SavedCocktailListVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let savedCocktailListDIContainer = SavedCocktailListDIContainer()
        
        let vc = SavedCocktailListViewController(viewModel: savedCocktailListDIContainer.makeSavedCocktailListViewModel())
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
