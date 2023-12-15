//
//  LoginSettingViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/13.
//

import Foundation
import Combine

protocol LoginSettingViewModel {
    func logout()
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

final class DefaultLoginSettingViewModel: LoginSettingViewModel {
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
    
    func logout() {
        authenticationManager.logout()
    }
}
