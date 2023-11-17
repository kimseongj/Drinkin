//
//  DefaultItemFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

final class DefaultItemFilterRepository: ItemFilterRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchIngredientFilter() -> AnyPublisher<ItemFilterList, APIError> {
        return provider.fetchData(endpoint: endpoint)
    }
}
