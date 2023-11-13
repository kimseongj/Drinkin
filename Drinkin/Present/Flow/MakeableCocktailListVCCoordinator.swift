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
    let baseBrandID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, baseBrandID: Int) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.baseBrandID = baseBrandID
    }
    
    func start() {
        let makeableCocktailListDIContainer = appDIContainer.makeMakeableCocktailListDIContainer(brandID: baseBrandID)
        
        let vc = makeableCocktailListDIContainer.makeMakeableCocktailListViewController()
        vc.makeBlackBackBarButton()
        vc.flowDelegate = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
