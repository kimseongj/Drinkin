//
//  DefaultUserMadeCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

final class DefaultUserMadeCocktailListRepository: UserMadeCocktailListRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchUserMadeCocktailList() -> AnyPublisher<CocktailPreviewList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
