//
//  ToolModalVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class ToolModalVCCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let toolID: Int

    init(navigationController: UINavigationController, toolID: Int) {
        self.navigationController = navigationController
        self.toolID = toolID
    }
    
    func start() {
        let repository: ToolDetailRepository = DefaultToolDetailRepository(toolID: toolID)
        let viewModel: ToolModalViewModel = DefaultToolModalViewModel(toolDetailRepository: repository)
        let vc = ToolModalViewController(viewModel: viewModel)
        
        navigationController.present(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) { }
}
