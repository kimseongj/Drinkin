//
//  LoginManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/21.
//

import Foundation

struct LoginManager {
    let tokenManager = DefaultTokenManager()
    private func isAuthenticated() -> Bool {
        do {
            let accessToken = try tokenManager.readToken(tokenType: TokenType.accessToken)
            return accessToken != nil
        } catch {
            return false
        }
    }
}
