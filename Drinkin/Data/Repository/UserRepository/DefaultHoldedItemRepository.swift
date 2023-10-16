//
//  DefaultHoldedItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/04.
//

import Foundation
import Combine

protocol HoldedItemRepository {
    func fetchHoldedItem() -> AnyPublisher<HoldedItem, Error>
}

final class DefaultHoldedItemRepository: HoldedItemRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchHoldedItem() -> AnyPublisher<HoldedItem, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
