//
//  SkillModalVCCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import UIKit

class SkillModalVCCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let skillID: Int

    init(navigationController: UINavigationController, skillID: Int) {
        self.navigationController = navigationController
        self.skillID = skillID
    }
    
    func start() {
        let repository: SkillDetailRepository = DefaultSkillDetailRepository(skillID: skillID)
        let viewModel: SkillModalViewModel = DefaultSkillModalViewModel(skillDetailRepository: repository)
        let skillModalViewController = SkillModalViewController(viewModel: viewModel)
        
        navigationController.present(skillModalViewController, animated: true)
    }
}
