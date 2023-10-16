//
//  DefaultCocktailPreviewListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol CocktailPreviewListRepository {
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error>
}

final class DefaultCocktailPreviewListRepository: CocktailPreviewListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
