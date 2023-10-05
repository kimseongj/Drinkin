//
//  AppCoordinator.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/07.


import UIKit

class AppCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow?
    let appDIContainer: AppDIContainer
    static var tabBarHeight: CGFloat = 0
    
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
    
    func configureTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black]
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        let mainTabBarItem = UITabBarItem(title: TabBarTitleStrings.main,
                                          image: ImageStorage.homeIcon?.withRenderingMode(.alwaysOriginal),
                                          selectedImage: ImageStorage.homeFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let cocktailTabBarItem = UITabBarItem(title: TabBarTitleStrings.cocktail,
                                              image: ImageStorage.cocktailIcon?.withRenderingMode(.alwaysOriginal),
                                              selectedImage: ImageStorage.cocktailFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let homeBarTabBarItem = UITabBarItem(title: TabBarTitleStrings.myHomeBar,
                                             image: ImageStorage.myBarIcon?.withRenderingMode(.alwaysOriginal),
                                             selectedImage: ImageStorage.myBarFillIcon?.withRenderingMode(.alwaysOriginal))
        
        let mainVCCoordinator = MainVCCoordinator(appDIContainer: appDIContainer)
        let mainViewController = mainVCCoordinator.startPush()
        mainViewController.tabBarItem = mainTabBarItem
        
        let cocktailFilterVCCoordinator = CocktailFilterVCCoordinator(appDIContainer: appDIContainer)
        let cocktailViewController = cocktailFilterVCCoordinator.startPush()
        cocktailViewController.tabBarItem = cocktailTabBarItem
        
        let homeBarVCCoordinator = HomeBarVCCoordinator(appDIContainer: appDIContainer)
        let homeBarViewController = homeBarVCCoordinator.startPush()
        homeBarViewController.tabBarItem = homeBarTabBarItem
        
        tabBarController.viewControllers = [mainViewController,
                                            cocktailViewController,
                                            homeBarViewController]
        
        return tabBarController
    }
    
    func childDidFinish(_ child: Coordinator?) { }
}
