//
//  LoginSettingViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/13.
//

import Foundation

protocol LoginSettingViewModel {
    func logout()
}

final class DefaultLoginSettingViewModel: LoginSettingViewModel {
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
    
    func logout() {
        authenticationManager.logout()
    }
}
