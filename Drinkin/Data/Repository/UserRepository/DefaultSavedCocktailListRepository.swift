//
//  DefaultSavedCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation
import Combine

final class DefaultSavedCocktailListRepository: SavedCocktailListRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchSavedCocktailList() -> AnyPublisher<CocktailPreviewList, APIError> {
        return provider.fetchData(endpoint: endpoint)
    }
}
