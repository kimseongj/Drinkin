//
//  CocktailFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

final class DefaultCocktailFilterRepository: CocktailFilterRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailFilter() -> AnyPublisher<CocktailFilter, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
