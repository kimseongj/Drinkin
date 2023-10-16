//
//  IngredientFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol IngredientFilterRepository {
    func fetchPublisher() -> AnyPublisher<IngredientFilter, Error>
}

final class DefaultIngredientFilterRepository: IngredientFilterRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<IngredientFilter, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
