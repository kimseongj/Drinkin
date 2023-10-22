//
//  DefaultItemFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

final class DefaultItemFilterRepository: ItemFilterRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchIngredientFilter() -> AnyPublisher<ItemFilterList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
