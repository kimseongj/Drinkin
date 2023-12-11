//
//  DefaultIngredientDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/10.
//

import Foundation
import Combine

final class DefaultIngredientDetailRepository: IngredientDetailRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let ingredientID: Int
    
    init(provider: Provider, endpoint: EndpointMakeable, ingredientID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.ingredientID = ingredientID
    }
    
    func fetchIngredientDetail() -> AnyPublisher<IngredientDetail, APIError> {
        endpoint.insertPathParmeter(pathParameter: String(ingredientID))
        
        return provider.fetchData(endpoint: endpoint)
    }
}
