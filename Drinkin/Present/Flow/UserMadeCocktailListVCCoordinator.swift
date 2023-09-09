//
//  UserMadeCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/09.
//

import UIKit

class UserMadeCocktailListVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = CocktailListViewController(viewControllerTitle: "만들어본 칵테일 목록")
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
