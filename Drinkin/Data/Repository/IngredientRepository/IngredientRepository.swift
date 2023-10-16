//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

protocol IngredientRepository {
    func fetchIngredientList() -> AnyPublisher<IngredientDescription, Error>
    func postIngredientList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error>
}

final class DefaultIngredientRepository: IngredientRepository {
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
    
    func fetchIngredientList() -> AnyPublisher<IngredientDescription, Error> {
        return provider.fetchData(endpoint: ingredientListEndpoint)
    }
    
    func postIngredientList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return provider.postData(endpoint: addIngredientEndpoint, bodyItem: receipeItems)
    }
}
