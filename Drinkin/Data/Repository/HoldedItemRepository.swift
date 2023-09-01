//
//  HoldedItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/04.
//

import Foundation
import Combine

protocol HoldedItemRepository {
    func fetchPublisher() -> AnyPublisher<HoldedItem, Error>
}

final class DefaultHoldedItemRepository: HoldedItemRepository {
    let provider = Provider()
    let endpoint = HoldedItemEndpoint()
    
    func fetchPublisher() -> AnyPublisher<HoldedItem, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
