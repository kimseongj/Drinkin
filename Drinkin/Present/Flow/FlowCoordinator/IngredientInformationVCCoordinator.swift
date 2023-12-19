//
//  IngredientInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/09.
//

import UIKit

protocol IngredientInformationVCFlow: AnyObject {
    func pushMakeableCocktailListVC(ingredientID: Int)
}

final class IngredientInformationVCCoordinator: Coordinator, IngredientInformationVCFlow {
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

        let ingredientInformationVC = ingredientInformationDIContainer.makeIngredientInformationViewController()
        ingredientInformationVC.makeBlackBackBarButton()
        ingredientInformationVC.flowDelegate = self
        
        navigationController.pushViewController(ingredientInformationVC, animated: true)
    }


    func pushMakeableCocktailListVC(ingredientID: Int) {
        let makeableCocktailListVCCoordinator = MakeableCocktailListVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer, baseBrandID: nil, ingredientID: ingredientID)
        makeableCocktailListVCCoordinator.start()
    }
}
