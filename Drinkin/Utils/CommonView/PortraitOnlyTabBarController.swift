//
//  PortraitOnlyTabBarController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/27.
//

import UIKit

final class PortraitOnlyTabBarController: UITabBarController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
