//
//  BaseInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import UIKit

final class BaseInformationVCCoordinator: Coordinator {
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
        let vc = baseInformationDIContainer.makeBaseInformationViewController()
        vc.makeBlackBackBarButton()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
