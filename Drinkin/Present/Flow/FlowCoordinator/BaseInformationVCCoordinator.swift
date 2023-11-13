//
//  BaseInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import UIKit

protocol BaseInformationVCFlow {
    func pushBaseBrandInformationVC(brandID: Int)
}

final class BaseInformationVCCoordinator: Coordinator, BaseInformationVCFlow {
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    let baseID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, baseID: Int) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.baseID = baseID
    }
    
    func start() {
        let baseInformationDIContainer = appDIContainer.makeBaseInformationDIContainer(baseID: baseID)
        let baseInformationViewController = baseInformationDIContainer.makeBaseInformationViewController()
        baseInformationViewController.flowDelegate = self
        baseInformationViewController.makeBlackBackBarButton()
        navigationController.pushViewController(baseInformationViewController, animated: true)
    }
    
    func pushBaseBrandInformationVC(brandID: Int) {
        let baseBrandInformationVCCoordinator = BaseBrandInformationVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer, baseBrandID: brandID)
        baseBrandInformationVCCoordinator.start()
    }
}
