//
//  DefaultCocktailPreviewListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

final class DefaultCocktailPreviewListRepository: CocktailPreviewListRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let cocktailID: Int
    
    init(provider: Provider, endpoint: EndpointMakeable, cocktailID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.cocktailID = cocktailID
    }
    
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, APIError> {
        provider.fetchData(endpoint: endpoint)
    }
}
