//
//  AuthenticationManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/20.
//

import Combine

protocol AuthenticationManager {
    func login(accessToken: String, refreshToken: String)
    func logout()
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}
