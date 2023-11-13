//
//  LoginManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/03.
//

import Foundation
import Combine

final class LoginManager {
    static let shared = LoginManager()
    
    let tokenManager = TokenManager()
    var renewAccessTokenEndpoint = RenewAccessTokenEndpoint()
    
    
    func renewAccessTokenPublisher() -> AnyPublisher<AccessToken, Error> {
        var renewAccessTokenEndpoint = RenewAccessTokenEndpoint()
        do {
            if let refreshToken = try tokenManager.readToken(tokenType: TokenType.refreshToken) {
                renewAccessTokenEndpoint.insertQuery(queryParameter: "refresh_token",
                                                     queryValue: refreshToken)
            }
        } catch {
            
        }
        
        let request = renewAccessTokenEndpoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: AccessToken.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func checkTokenExistence() -> Bool {
        var tokenExistence: Bool = false
        
        do {
            if (try tokenManager.readToken(tokenType: TokenType.accessToken)) != nil {
                tokenExistence = true
            }
        } catch KeychainError.noPassword {
            tokenExistence = false
        } catch {
            
        }
        
        return tokenExistence
    }
}

