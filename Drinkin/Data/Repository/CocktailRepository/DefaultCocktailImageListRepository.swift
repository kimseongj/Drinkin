//
//  DefaultCocktailImageListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

final class DefaultCocktailImageListRepository: CocktailImageListRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
