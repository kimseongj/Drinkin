//
//  GlassModalVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class GlassModalVCCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let glassID: Int

    init(navigationController: UINavigationController, glassID: Int) {
        self.navigationController = navigationController
        self.glassID = glassID
    }
    
    func start() {
        let repository: GlassDetailRepository = DefaultGlassDetailRepository(glassID: glassID)
        let viewModel: GlassModalViewModel = DefaultGlassModalViewModel(glassDetailRepository: repository)
        let glassModalViewController = GlassModalViewController(viewModel: viewModel)
        
        navigationController.present(glassModalViewController, animated: true)
    }
}
