//
//  BaseBrandInformationVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import UIKit

final class BaseBrandInformationVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
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
        
        let vc = baseBrandInformationDIContainer.makeBaseBrandInformationViewController()
        vc.makeBlackBackBarButton()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
