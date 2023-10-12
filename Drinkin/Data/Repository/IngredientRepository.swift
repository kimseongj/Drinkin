//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation

import Foundation
import Combine

protocol IngredientRepository {
    func fetchPublisher() -> AnyPublisher<IngredientDescription, Error>
}

final class DefaultIngredientRepository: IngredientRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<IngredientDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
