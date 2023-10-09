//
//  CocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

protocol CocktailListRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
    func insertQuery(queryParameter: String, queryValue: String)
}

final class DefaultCocktailListRepository: CocktailListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
    
    func insertQuery(queryParameter: String, queryValue: String) {
        endpoint.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
    }
}
