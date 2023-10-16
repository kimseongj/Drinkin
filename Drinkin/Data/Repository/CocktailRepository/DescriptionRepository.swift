//
//  DescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol DescriptionRepository {
    func fetchPublisher() -> AnyPublisher<CocktailDescription, Error>
}

class DefaultDescriptionRepository: DescriptionRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    let cocktailID: Int
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable, cocktailID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.cocktailID = cocktailID
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailDescription, Error> {
        endpoint.insertPathParmeter(pathParameter: cocktailID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}


