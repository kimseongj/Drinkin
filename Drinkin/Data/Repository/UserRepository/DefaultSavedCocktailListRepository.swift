//
//  DefaultSavedCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation
import Combine

final class DefaultSavedCocktailListRepository: SavedCocktailListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchSavedCocktailList() -> AnyPublisher<CocktailPreviewList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
