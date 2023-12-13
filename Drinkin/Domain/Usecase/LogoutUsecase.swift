//
//  LogoutUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/12.
//

import Foundation

protocol LogoutUsecase {
    
}

final class DefaultLogoutUsecase: LogoutUsecase {
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
}
