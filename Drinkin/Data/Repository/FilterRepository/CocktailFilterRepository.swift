//
//  CocktailFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol CocktailFilterRepository {
    func fetchCocktailFilter() -> AnyPublisher<CocktailFilter, Error>
}

final class DefaultCocktailFilterRepository: CocktailFilterRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailFilter() -> AnyPublisher<CocktailFilter, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
