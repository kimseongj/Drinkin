//
//  Saved.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation
import Combine

protocol SavedCocktailListRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultSavedCocktailListRepository: SavedCocktailListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
