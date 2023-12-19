//
//  LoginSettingDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

final class LoginSettingDIContainer {
    private let provider: Provider
    private let authenticationManager: AuthenticationManager
    
    init(provider: Provider,
         authenticationManager: AuthenticationManager) {
        self.provider = provider
        self.authenticationManager = authenticationManager
    }
    
    func makeLoginSettingViewModel() -> LoginSettingViewModel {
        DefaultLoginSettingViewModel(authenticationManager: authenticationManager)
    }
    
    func makeLoginSettingViewController() -> LoginSettingViewController {
        LoginSettingViewController(viewModel: makeLoginSettingViewModel())
    }
}
