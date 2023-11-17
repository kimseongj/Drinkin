//
//  LoginProvider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

protocol LoginProvider {
    func postAccessToken(endpoint: EndpointMakeable, accessToken: String) -> AnyPublisher<LoginToken, Error>
}

struct DefaultLoginProvider: LoginProvider {
    private let tokenManager: TokenManager

    init(tokenManager: TokenManager) {
        self.tokenManager = tokenManager
    }
    
    func postAccessToken(endpoint: EndpointMakeable, accessToken: String) -> AnyPublisher<LoginToken, Error> {
        let encodableAccessToken = AccessToken(accessToken: accessToken)
        
        let request = endpoint.makeJsonPostRequest(bodyItem: encodableAccessToken)
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: LoginToken.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
