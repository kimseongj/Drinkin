//
//  DefaultCocktailBriefListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

class DefaultCocktailBriefListRepository: CocktailBriefListRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailBriefList() -> AnyPublisher<CocktailBriefList, APIError> {
        provider.fetchData(endpoint: endpoint)
    }
}
