//
//  DefaultCocktailDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

final class DefaultCocktailDetailRepository: CocktailDetailRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let cocktailID: Int
    
    init(provider: Provider, endpoint: EndpointMakeable, cocktailID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.cocktailID = cocktailID
    }
    
    func fetchCocktailDescription() -> AnyPublisher<CocktailDescription, Error> {
        endpoint.insertPathParmeter(pathParameter: cocktailID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
