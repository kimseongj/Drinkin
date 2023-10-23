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
    let ingredientListEndpoint: EndpointMakeable
    let addIngredientEndpoint: EndpointMakeable
    
    init(tokenManager: TokenManager,
         provider: Provider,
         ingredientListEndpoint: EndpointMakeable,
         addIngredientEndpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.ingredientListEndpoint = ingredientListEndpoint
        self.addIngredientEndpoint = addIngredientEndpoint
    }
    
    func fetchIngredientList() -> AnyPublisher<ItemList, Error> {
        return provider.fetchData(endpoint: ingredientListEndpoint)
    }
    
    func postIngredientList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return provider.postData(endpoint: addIngredientEndpoint, bodyItem: receipeItems)
    }
}
