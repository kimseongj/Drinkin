//
//  ProductDetailVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.


import UIKit

class ProductDetailVCCoordinator: Coordinator, ProductDetailViewDelegate {
    
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
        
        productDetailViewController.cocktailInformationView.toolView.delegate = self

        productDetailViewController.cocktailInformationView.glassView.delegate = self

        navigationController.pushViewController(productDetailViewController, animated: true)
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
}
