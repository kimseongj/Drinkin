//
//  DefaultLoginRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation
import Combine

final class DefaultLoginRepository: LoginRepository {
    let loginProvider: LoginProvider
    let kakaoLoginEndpoint: EndpointMakeable
    let appleLoginEndpoint: EndpointMakeable
    
    init(loginProvider: LoginProvider,
         kakaoLoginEndpoint: EndpointMakeable,
         appleLoginEndpoint: EndpointMakeable) {
        self.loginProvider = loginProvider
        self.kakaoLoginEndpoint = kakaoLoginEndpoint
        self.appleLoginEndpoint = appleLoginEndpoint
    }
    
    func kakaoLoginPublisher(accessToken: String) -> AnyPublisher<LoginToken, Error> {
        loginProvider.postAccessToken(endpoint: kakaoLoginEndpoint, accessToken: accessToken)
    }
    
    func appleLoginPublisher(accessToken: String) -> AnyPublisher<LoginToken, Error> {
        loginProvider.postAccessToken(endpoint: appleLoginEndpoint, accessToken: accessToken)
    }
}
