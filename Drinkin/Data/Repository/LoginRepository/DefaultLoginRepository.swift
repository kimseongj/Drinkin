//
//  DefaultLoginRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation
import Combine

final class DefaultLoginRepository: LoginRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
}
