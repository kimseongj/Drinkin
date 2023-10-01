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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = BaseInformationViewController()
        vc.makeBlackBackBarButton()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        parentCoordinator?.childDidFinish(self)
    }
}
