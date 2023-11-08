//
//  DefaultCocktailImageListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

final class DefaultCocktailImageListRepository: CocktailImageListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
