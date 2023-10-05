//
//  BriefDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol BriefDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<CocktailBriefDescription, Error>
}

class DefaultBriefDescriptionRepository: BriefDescriptionRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailBriefDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
