//
//  DefaultLoginRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation
import Combine

final class DefaultLoginRepository: LoginRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
}
