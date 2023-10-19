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
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    //var baseID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        //self.baseID = baseID
    }
    
    func start() {
        let baseInformationDIContainer = appDIContainer.makeBaseInformationDIContainer()
        //let baseInformationViewModel =
        let baseInformationViewController = baseInformationDIContainer.makeBaseInformationViewController()
        baseInformationViewController.flowDelegate = self
        baseInformationViewController.makeBlackBackBarButton()
        navigationController.pushViewController(baseInformationViewController, animated: true)
    }
    
    func pushBaseBrandInformationVC(brandID: Int) {
        let baseBrandInformationVCCoordinator = BaseBrandInformationVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer, baseBrandID: brandID)
        baseBrandInformationVCCoordinator.parentCoordinator = self
        childCoordinators.append(baseBrandInformationVCCoordinator)
        baseBrandInformationVCCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
