//
//  DefaultMakeableCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation
import Combine

final class DefaultMakeableCocktailListRepository: MakeableCocktailListRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let brandID: Int
    
    init(provider: Provider,
         endpoint: EndpointMakeable,
         brandID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.brandID = brandID
    }
    
    func fetchMakeableCocktails() -> AnyPublisher<MakeableCocktailList, Error> {
        //endpoint.insertPathParmeter(pathParameter: brandID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
