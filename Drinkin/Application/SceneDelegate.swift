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
    let tokenManager = DefaultTokenManager()
    lazy var provider = DefaultProvider(tokenManager: tokenManager)
    lazy var loginProvider = DefaultLoginProvider(tokenManager: tokenManager)
    lazy var authenticationManager = DefaultAuthenticationManager(tokenManager: tokenManager)
    lazy var appDIContainer = AppDIContainer(provider: provider,
                                             loginProvider: loginProvider,
                                             authenticationManager: authenticationManager)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.appCoordinator = AppCoordinator(window, appDIContainer: appDIContainer)
        appCoordinator?.start()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}
