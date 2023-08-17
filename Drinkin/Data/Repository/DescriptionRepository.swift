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
    let provider = Provider()
    var endpoint = ProductDetailEndpoint()
    
    private let cocktailID: Int
    
    init(cocktailID: Int) {
        self.cocktailID = cocktailID
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailDescription, Error> {
        endpoint.insertPathParmeter(id: cocktailID)
        
        return provider.fetchData1(endpoint: endpoint)
    }
}


