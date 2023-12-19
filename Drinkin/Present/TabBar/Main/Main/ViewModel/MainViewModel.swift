//
//  MainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/12.
//

import Foundation
import Combine

protocol MainViewModel {
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

final class DefaultMainViewModel: MainViewModel {
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
}
