//
//  LoginDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation

final class LoginDIContainer {
    let loginProvider: LoginProvider
    let kakaoLoginEndpoint = KakaoAccessTokenConversionEndpoint()
    let appleLoginEndpoint = AppleAccessTokenConversionEndpoint()
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
    }
    
    func makeLoginRepository() -> LoginRepository {
        return DefaultLoginRepository(loginProvider: loginProvider,
                                      kakaoLoginEndpoint: kakaoLoginEndpoint,
                                      appleLoginEndpoint: appleLoginEndpoint)
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return DefaultLoginViewModel(loginRepository: makeLoginRepository())
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
}
