//
//  AppCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.


import UIKit

class AppCoordinator: NSObject, Coordinator {
    let window: UIWindow?
    let appDIContainer: AppDIContainer
    static var tabBarHeight: CGFloat = 0
    static let tabBarController = PortraitOnlyTabBarController()
    
    init(_ window: UIWindow?, appDIContainer: AppDIContainer) {
        self.window = window
        self.appDIContainer = appDIContainer
        window?.makeKeyAndVisible()
    }
    
    func start() {
        let tabBarController = configureTabBarController()
        self.window?.rootViewController = tabBarController
        AppCoordinator.tabBarHeight = tabBarController.tabBar.frame.size.height
    }
    
    func configureTabBarController() -> PortraitOnlyTabBarController {
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        let mainTabBarItem = UITabBarItem(title: TabBarTitleStrings.main,
                                          image: ImageStorage.homeIcon?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: ImageStorage.homeFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let cocktailTabBarItem = UITabBarItem(title: TabBarTitleStrings.cocktail,
                                              image: ImageStorage.cocktailIcon?.withRenderingMode(.alwaysOriginal),
                                              selectedImage: ImageStorage.cocktailFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let myHomeBarTabBarItem = UITabBarItem(title: TabBarTitleStrings.myHomeBar,
                                               image: ImageStorage.myBarIcon?.withRenderingMode(.alwaysOriginal),
                                               selectedImage: ImageStorage.myBarFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let mainVCCoordinator = MainVCCoordinator(appDIContainer: appDIContainer)
        let mainViewController = mainVCCoordinator.startPush()
        mainViewController.tabBarItem = mainTabBarItem
        
        let cocktailFilterVCCoordinator = CocktailFilterVCCoordinator(appDIContainer: appDIContainer)
        let cocktailViewController = cocktailFilterVCCoordinator.startPush()
        cocktailViewController.tabBarItem = cocktailTabBarItem
        
        let myHomeBarVCCoordinator = MyHomeBarVCCoordinator(appDIContainer: appDIContainer)
        let myHomeBarViewController = myHomeBarVCCoordinator.startPush()
        myHomeBarViewController.tabBarItem = myHomeBarTabBarItem
        
        AppCoordinator.tabBarController.viewControllers = [mainViewController,
                                                           cocktailViewController,
                                                           myHomeBarViewController]
        
        return AppCoordinator.tabBarController
    }
}
