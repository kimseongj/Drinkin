//
//  DefaultItemSelectionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

final class DefaultItemSelectionRepository: ItemRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider,
         endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchItemData() -> AnyPublisher<ItemSelectionList, APIError> {
        return provider.fetchData(endpoint: endpoint)
    }
}
