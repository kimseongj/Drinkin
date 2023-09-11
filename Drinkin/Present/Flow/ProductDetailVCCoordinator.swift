//
//  ProductDetailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.

import UIKit

protocol ProductDetailVCDelegate: AnyObject {
    func pushToolModalVC()
    func pushSkillModalVC()
    func pushGlassModalVC()
    func didFinishProductDetailVC()
}

class ProductDetailVCCoordinator: Coordinator, ProductDetailVCDelegate {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var cocktailID: Int
    
    init(navigationController: UINavigationController, cocktailID: Int) {
        self.navigationController = navigationController
        self.cocktailID = cocktailID
    }
    
    func start() {
        let productDetailDIContainer = ProductDetailDIContainer()
        
        let productDetailViewController = ProductDetailViewController(viewModel: productDetailDIContainer.makeProductDetailViewModel(cocktailID: cocktailID))
        
        productDetailViewController.delegate = self
        productDetailViewController.cocktailInformationView.toolView.delegate = self
        productDetailViewController.cocktailInformationView.skillView.delegate = self
        productDetailViewController.cocktailInformationView.glassView.delegate = self
        
        navigationController.pushViewController(productDetailViewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
    
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
