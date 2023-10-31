//
//  DefaultMakeableCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation
import Combine

final class DefaultMakeableCocktailListRepository: MakeableCocktailListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    let id: Int
    
    init(tokenManager: TokenManager,
         provider: Provider,
         endpoint: EndpointMakeable,
         id: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.id = id
    }
    
    func fetchMakeableCocktailsByBrand() -> AnyPublisher<MakeableCocktailList, Error> {
        endpoint.insertPathParmeter(pathParameter: id.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
    
    func fetchMakeableCocktailsByIngredient() -> AnyPublisher<MakeableCocktailList, Error> {
        endpoint.insertPathParmeter(pathParameter: id.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
