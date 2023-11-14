//
//  DefaultItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

final class DefaultItemRepository: ItemRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider,
         endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchItemList() -> AnyPublisher<ItemList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
