//
//  BaseDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation
import Combine

protocol BaseDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<BaseDescription, Error>
}

final class DefaultBaseDescriptionRepository: BaseDescriptionRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<BaseDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
