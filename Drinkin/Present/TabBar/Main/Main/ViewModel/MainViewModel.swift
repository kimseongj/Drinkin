//
//  MainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/12.
//

import Foundation
import Combine

protocol MainViewModel {
    var isAuthenticated: Bool { get }
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

final class DefaultMainViewModel: MainViewModel {
    private let authenticationManager: AuthenticationManager
    var isAuthenticated: Bool = false
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
        checkIsAuthenticated()
    }
    
    func checkIsAuthenticated() {
        isAuthenticated = authenticationManager.isAuthenticated()
    }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
}
