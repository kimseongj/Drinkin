//
//  ProductDetailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

protocol ProductDetailVCDelegate: AnyObject {
    func pushBaseInformationVC()
    func pushToolModalVC()
    func pushSkillModalVC()
    func pushGlassModalVC()
    func didFinishProductDetailVC()
}

class ProductDetailVCCoordinator: Coordinator, ProductDetailVCDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let appDIContainer: AppDIContainer
    var cocktailID: Int
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer, cocktailID: Int) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.cocktailID = cocktailID
    }
    
    func start() {
        let productDetailDIContainer = appDIContainer.makeProductDetailDIContainer()
        let productDetailViewModel =  productDetailDIContainer.makeProductDetailViewModel(cocktailID: cocktailID)
        let productDetailViewController = productDetailDIContainer.makeProductDetailViewController(viewModel: productDetailViewModel)
        
        productDetailViewController.delegate = self
        productDetailViewController.cocktailInformationView.toolView.delegate = self
        productDetailViewController.cocktailInformationView.skillView.delegate = self
        productDetailViewController.cocktailInformationView.glassView.delegate = self
        productDetailViewController.makeBlackBackBarButton()
        
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
    
    func pushBaseInformationVC() {
        let baseInformationVCCoordinator = BaseInformationVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer)
        
        baseInformationVCCoordinator.parentCoordinator = self
        childCoordinators.append(baseInformationVCCoordinator)
        baseInformationVCCoordinator.start()
    }
    
    func pushToolModalVC() {
        let toolModalVCCoordinator = ToolModalVCCoordinator(navigationController: navigationController)
        
        toolModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(toolModalVCCoordinator)
        toolModalVCCoordinator.start()
    }
    
    func pushSkillModalVC() {
        let buildModalVCCoordinator = SkillModalVCCoordinator(navigationController: navigationController)
        
        buildModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(buildModalVCCoordinator)
        buildModalVCCoordinator.start()
    }
    
    func pushGlassModalVC() {
        let glassModalVCCoordinator = GlassModalVCCoordinator(navigationController: navigationController)
        
        glassModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(glassModalVCCoordinator)
        glassModalVCCoordinator.start()
    }
    
    func didFinishProductDetailVC() {
        parentCoordinator?.childDidFinish(self)
    }
}
