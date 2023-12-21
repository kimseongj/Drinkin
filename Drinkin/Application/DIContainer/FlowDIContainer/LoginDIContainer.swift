//
//  LoginDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation

final class LoginDIContainer {
    private let loginProvider: LoginProvider
    private let authenticationManager: AuthenticationManager
    private let kakaoLoginEndpoint = KakaoAccessTokenConversionEndpoint()
    private let appleLoginEndpoint = AppleAccessTokenConversionEndpoint()
    
    init(loginProvider: LoginProvider,
         authenticationManager: AuthenticationManager) {
        self.loginProvider = loginProvider
        self.authenticationManager = authenticationManager
    }
    
    func makeLoginRepository() -> LoginRepository {
        DefaultLoginRepository(loginProvider: loginProvider,
                                      kakaoLoginEndpoint: kakaoLoginEndpoint,
                                      appleLoginEndpoint: appleLoginEndpoint)
    }
    
    func makeLoginUsecase() -> LoginUsecase {
        DefaultLoginUsecase(loginRepository: makeLoginRepository(),
                            authenticationManager: authenticationManager)
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        DefaultLoginViewModel(loginUsecase: makeLoginUsecase())
    }
    
    func makeLoginViewController() -> LoginViewController {
        LoginViewController(viewModel: makeLoginViewModel())
    }
}
