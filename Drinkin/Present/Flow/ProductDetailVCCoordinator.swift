//
//  ProductDetailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

protocol ProductDetailVCDelegate: AnyObject {
    func pushBaseInformationVC(baseID: Int)
    func pushToolModalVC(toolID: Int)
    func pushSkillModalVC(skillID: Int)
    func pushGlassModalVC(glassID: Int)
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
        let productDetailDIContainer = appDIContainer.makeProductDetailDIContainer(cocktailID: cocktailID)
        let productDetailViewModel =  productDetailDIContainer.makeProductDetailViewModel()
        let productDetailViewController = productDetailDIContainer.makeProductDetailViewController(viewModel: productDetailViewModel)
        
        productDetailViewController.delegate = self
        productDetailViewController.cocktailInformationView.toolView.delegate = self
        productDetailViewController.cocktailInformationView.skillView.delegate = self
        productDetailViewController.cocktailInformationView.glassView.delegate = self
        productDetailViewController.makeBlackBackBarButton()
        
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
    
    func pushBaseInformationVC(baseID: Int) {
        let baseInformationVCCoordinator = BaseInformationVCCoordinator(navigationController: navigationController, appDIContainer: appDIContainer, baseID: baseID)
        
        baseInformationVCCoordinator.parentCoordinator = self
        childCoordinators.append(baseInformationVCCoordinator)
        baseInformationVCCoordinator.start()
    }
    
    func pushToolModalVC(toolID: Int) {
        let toolModalVCCoordinator = ToolModalVCCoordinator(navigationController: navigationController, toolID: toolID)
        
        toolModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(toolModalVCCoordinator)
        toolModalVCCoordinator.start()
    }
    
    func pushSkillModalVC(skillID: Int) {
        let buildModalVCCoordinator = SkillModalVCCoordinator(navigationController: navigationController, skillID: skillID)
        
        buildModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(buildModalVCCoordinator)
        buildModalVCCoordinator.start()
    }
    
    func pushGlassModalVC(glassID: Int) {
        let glassModalVCCoordinator = GlassModalVCCoordinator(navigationController: navigationController, glassID: glassID)
        
        glassModalVCCoordinator.parentCoordinator = self
        childCoordinators.append(glassModalVCCoordinator)
        glassModalVCCoordinator.start()
    }
    
    func didFinishProductDetailVC() {
        parentCoordinator?.childDidFinish(self)
    }
}
