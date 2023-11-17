//
//  DefaultHoldedItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/04.
//

import Foundation
import Combine

final class DefaultHoldedItemRepository: HoldedItemRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchHoldedItem() -> AnyPublisher<HoldedItem, APIError> {
        return provider.fetchData(endpoint: endpoint)
    }
}
