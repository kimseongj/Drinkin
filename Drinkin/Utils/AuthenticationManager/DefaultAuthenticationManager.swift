//
//  DefaultAuthenticationManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/21.
//

import Foundation
import Combine

final class DefaultAuthenticationManager: AuthenticationManager {
    private let tokenManager: TokenManager
    
    private lazy var isAuthenticatedSubject = CurrentValueSubject<Bool, Never>(isAuthenticated())
    
    init(tokenManager: TokenManager) {
        self.tokenManager = tokenManager
        
    }
    
    func isAuthenticated() -> Bool {
        do {
            let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken)
            return accessToken != nil
        } catch {
            return false
        }
    }
    
    func login(accessToken: String, refreshToken: String) {
        do {
            try tokenManager.saveToken(tokenType: TokenType.accessToken, token: accessToken)
            try tokenManager.saveToken(tokenType: TokenType.refreshToken, token: refreshToken)
            isAuthenticatedSubject.send(true)
        } catch {
            
        }
    }
    
    func logout() {
        do {
            try tokenManager.deleteToken(tokenType: TokenType.accessToken)
            try tokenManager.deleteToken(tokenType: TokenType.refreshToken)
            isAuthenticatedSubject.send(false)
        } catch {
            
        }
    }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
            return isAuthenticatedSubject.eraseToAnyPublisher()
        }
}
