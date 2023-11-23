//
//  LoginManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/21.
//

import Foundation

final class LoginManager {
    static let shared = LoginManager()
    let tokenManager: TokenManager = DefaultTokenManager()
    
    private init() {}
    
    func isAuthenticated() -> Bool {
        do {
            let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken)
            return accessToken != nil
        } catch {
            return false
        }
    }
}
