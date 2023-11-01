//
//  DefaultCocktailQueryRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

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
        if endpoint.queryItems.contains(where: { $0.name == queryParameter }) {
            endpoint.queryItems.removeAll(where: { $0.name == queryParameter })
        }
        endpoint.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
    }
    
    func removeQuery(queryParameter: String) {
        endpoint.removeQuery(queryParamter: queryParameter)
    }
    
    func removeAllQuery() {
        endpoint.removeAllQuery()
    }
}
