//
//  DefaultUserMadeCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListRepository {
    func fetchUserMadeCocktailList() -> AnyPublisher<CocktailPreviewList, Error>
}

final class DefaultUserMadeCocktailListRepository: UserMadeCocktailListRepository {    
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchUserMadeCocktailList() -> AnyPublisher<CocktailPreviewList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
