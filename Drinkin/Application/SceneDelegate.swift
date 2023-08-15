//
//  SceneDelegate.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/03.
//

import UIKit
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

//        self.window = UIWindow(windowScene: windowScene)
//        self.appCoordinator = AppCoordinator(window)
//        appCoordinator?.start()
        
         window = UIWindow(windowScene: windowScene) // SceneDelegate의 프로퍼티에 설정해줌
         let viewController = LoginViewController()
         window?.rootViewController = viewController//tabbarController//tabbarController
         window?.makeKeyAndVisible()
        
//        window = UIWindow(windowScene: windowScene) // SceneDelegate의 프로퍼티에 설정해줌
//        let viewController = ViewController()
//        window?.rootViewController = viewController//tabbarController//tabbarController
//        window?.makeKeyAndVisible()
//        
        
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
