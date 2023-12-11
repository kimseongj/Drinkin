//
//  MakeableCocktailListVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/12.
//

import UIKit

protocol MakeableCocktailListVCFlow: AnyObject {
    func pushProductDetailVC(cocktailID: Int)
}

final class MakeableCocktailListVCCoordinator: Coordinator, MakeableCocktailListVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    let baseBrandID: Int?
    let ingredientID: Int?
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer,
         baseBrandID: Int?,
         ingredientID: Int?) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.baseBrandID = baseBrandID
        self.ingredientID = ingredientID
    }
    
    func start() {
        let makeableCocktailListDIContainer = appDIContainer.makeMakeableCocktailListDIContainer(brandID: baseBrandID, ingredientID: ingredientID)
        
        let makeableCocktailListViewController = makeableCocktailListDIContainer.makeMakeableCocktailListViewController()
        makeableCocktailListViewController.makeBlackBackBarButton()
        makeableCocktailListViewController.flowDelegate = self
        
        navigationController.pushViewController(makeableCocktailListViewController, animated: true)
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
