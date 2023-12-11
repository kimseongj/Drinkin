//
//  BaseBrandInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import UIKit

protocol BaseBrandInformationVCFlow: AnyObject {
    func pushMakeableCocktailListVC(brandID: Int)
}

final class BaseBrandInformationVCCoordinator: Coordinator, BaseBrandInformationVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    let baseBrandID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, baseBrandID: Int) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.baseBrandID = baseBrandID
    }
    
    func start() {
        let baseBrandInformationDIContainer = appDIContainer.makeBaseBrandInformationDIContainer(brandID: baseBrandID)
        
        let baseBrandInformationVC = baseBrandInformationDIContainer.makeBaseBrandInformationViewController()
        baseBrandInformationVC.makeBlackBackBarButton()
        baseBrandInformationVC.flowDelegate = self
        
        navigationController.pushViewController(baseBrandInformationVC, animated: true)
    }
    
    func pushMakeableCocktailListVC(brandID: Int) {
        let makeableCocktailListVCCoordinator = MakeableCocktailListVCCoordinator(navigationController: navigationController,
                                                                                  appDIContainer: appDIContainer,
                                                                                  baseBrandID: brandID, ingredientID: nil)
        makeableCocktailListVCCoordinator.start()
    }
}
