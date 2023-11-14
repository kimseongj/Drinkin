//
//  LoginDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation

final class LoginDIContainer {
    let provider: Provider
    let kakaoAccessTokenConversionEndpoint = KakaoAccessTokenConversionEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeLoginRepository() -> LoginRepository {
        return DefaultLoginRepository(provider: provider,
                                      endpoint: kakaoAccessTokenConversionEndpoint)
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return DefaultLoginViewModel(loginRepository: makeLoginRepository())
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel())
    }
}
