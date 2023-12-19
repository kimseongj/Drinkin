//
//  MainVCCorrdinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/11.


import UIKit

protocol MainVCFlow: AnyObject {
    func presentLoginVC()
    func pushProductDetailVC(cocktailID: Int)
}

class MainVCCoordinator: Coordinator, MainVCFlow {
    var navigationController: UINavigationController
    var appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.navigationController = .init()
        self.appDIContainer = appDIContainer
    }
    
    func start() { }
    
    func startPush() -> UINavigationController {
        let mainDIContainer = appDIContainer.makeMainDIContainer()
        let mainViewController = mainDIContainer.makeMainViewController()
        
        mainViewController.makeBlackBackBarButton()
        mainViewController.flowDelegate = self
        navigationController.setViewControllers([mainViewController], animated: false)
        
        return navigationController
    }
    
    func presentLoginVC() {
        let loginVCCoordinator = LoginVCCoordinator(navigationController: navigationController,
                                                    appDIContainer: appDIContainer)
        loginVCCoordinator.start()
    }
    
    func pushProductDetailVC(cocktailID: Int) {
        let productDetailVCCoordinator = ProductDetailVCCoordinator(navigationController: navigationController,
                                                                    appDIContainer: appDIContainer,
                                                                    cocktailID: cocktailID)
        productDetailVCCoordinator.start()
    }
}
