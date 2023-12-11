//
//  LoginManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/21.
//

import Foundation

protocol LoginManager {
    func isAuthenticated() -> Bool
}

final class DefaultLoginManager: LoginManager {
    private let tokenManager: TokenManager
    
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
}
