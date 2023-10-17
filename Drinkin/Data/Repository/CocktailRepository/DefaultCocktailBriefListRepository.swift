//
//  DefaultCocktailBriefListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

class DefaultCocktailBriefListRepository: CocktailBriefListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailBriefList() -> AnyPublisher<CocktailBriefList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
