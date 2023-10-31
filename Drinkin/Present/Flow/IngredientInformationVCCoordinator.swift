//
//  IngredientInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import UIKit

final class IngredientInformationVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    let ingredientID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, ingredientID: Int) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.ingredientID = ingredientID
    }
    
    func start() {
        let ingredientInformationDIContainer = appDIContainer.makeIngredientInformationDIContainer(ingredientID: ingredientID)
        
        let vc = ingredientInformationDIContainer.makeIngredientInformationViewController()
        vc.makeBlackBackBarButton()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
    
//    func pushMakeableCocktailListVC(baseID: Int) {
//        let makeableCocktailListVCCoordinator = MakeableCocktailListVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer, baseID: baseID)
//        
//        makeableCocktailListVCCoordinator.parentCoordinator = self
//        childCoordinators.append(makeableCocktailListVCCoordinator)
//        makeableCocktailListVCCoordinator.start()
//    }
}
