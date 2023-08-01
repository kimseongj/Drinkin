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
    //let endpoint =
    let endpoint: EndpointMakeable? = nil
    
    func fetchPublisher() -> AnyPublisher<CocktailDescription, Error> {
        return provider.fetchData1(endpoint: endpoint!)
    }
}


