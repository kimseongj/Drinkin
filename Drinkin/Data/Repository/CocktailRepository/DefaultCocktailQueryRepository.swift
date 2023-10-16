//
//  DefaultCocktailQueryRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

protocol CocktailQueryRepository {
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error>
    func insertQuery(queryParameter: String, queryValue: String)
    func removeQuery(queryParameter: String)
    func removeAllQuery()
}

final class DefaultCocktailQueryRepository: CocktailQueryRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
    
    func insertQuery(queryParameter: String, queryValue: String) {
        endpoint.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
    }
    
    func removeQuery(queryParameter: String) {
        endpoint.removeQuery(queryParamter: queryParameter)
    }
    
    func removeAllQuery() {
        endpoint.removeAllQuery()
    }
}
