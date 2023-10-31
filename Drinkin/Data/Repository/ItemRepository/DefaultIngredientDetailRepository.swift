//
//  DefaultIngredientDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation
import Combine

final class DefaultIngredientDetailRepository: IngredientDetailRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    let ingredientID: Int
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable, ingredientID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.ingredientID = ingredientID
    }
    
    func fetchIngredientDetail() -> AnyPublisher<IngredientDetail, Error> {
        //endpoint.insertQuery(queryParameter: "ingredient_id", queryValue: ingredientID.description)
        return provider.fetchData(endpoint: endpoint)
    }
}
