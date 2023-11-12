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
    let brandID: Int
    
    init(tokenManager: TokenManager,
         provider: Provider,
         endpoint: EndpointMakeable,
         brandID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.brandID = brandID
    }
    
    func fetchMakeableCocktailsByBrand() -> AnyPublisher<MakeableCocktailList, Error> {
        endpoint.insertPathParmeter(pathParameter: brandID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
