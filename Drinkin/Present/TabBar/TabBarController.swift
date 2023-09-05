//
//  TabBarController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/06.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        let mainTabBarItem = UITabBarItem(title: "메인", image: UIImage(named: "home_icon"), selectedImage: UIImage(named: "home_fill_icon"))
        let cocktailTabBarItem = UITabBarItem(title: "칵테일", image: UIImage(named: "cocktail_list_icon"), selectedImage: UIImage(named: "cocktail_list_fill_icon"))
        let homeBarTabBarItem = UITabBarItem(title: "나의 홈바", image: UIImage(named: "my_bar_icon"), selectedImage: UIImage(named: "my_bar_fill_icon"))
        
        let mainVCCoordinator = MainVCCoordinator()
        let mainViewController = mainVCCoordinator.startPush()
        mainViewController.tabBarItem = mainTabBarItem
        
        let cocktailVCCoordinator = CocktailVCCoordinator()
        let cocktailViewController = cocktailVCCoordinator.startPush()
        cocktailViewController.tabBarItem = cocktailTabBarItem
        
        let homeBarVCCoordinator = HomeBarVCCoordinator()
        let homeBarViewController = homeBarVCCoordinator.startPush()
        homeBarViewController.tabBarItem = homeBarTabBarItem
        
        self.viewControllers = [mainViewController, cocktailViewController, homeBarViewController]
    }
}
