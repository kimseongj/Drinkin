//
//  DefaultItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

final class DefaultItemRepository: ItemRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let itemListEndpoint: EndpointMakeable
    let addItemEndpoint: EndpointMakeable
    
    init(tokenManager: TokenManager,
         provider: Provider,
         itemListEndpoint: EndpointMakeable,
         addItemEndpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.itemListEndpoint = itemListEndpoint
        self.addItemEndpoint = addItemEndpoint
    }
    
    func fetchItemList() -> AnyPublisher<ItemList, Error> {
        return provider.fetchData(endpoint: itemListEndpoint)
    }
    
    func postItemList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return provider.postData(endpoint: addItemEndpoint, bodyItem: receipeItems)
    }
}
