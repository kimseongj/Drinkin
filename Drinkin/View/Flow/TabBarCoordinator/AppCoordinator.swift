//
//  AppCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow?
    static var tabBarHeight: CGFloat = 0
    
    init(_ window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let tabBarController = TabBarController()
        self.window?.rootViewController = tabBarController
        AppCoordinator.tabBarHeight = tabBarController.tabBar.frame.size.height
    }
}
