//
//  DefaultCocktailMarkingRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/06.
//

import Foundation
import Combine

final class DefaultCocktailMarkingRepository: CocktailMarkingRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func postUserMadeCocktail(cocktail: Encodable) -> AnyPublisher<PostResponse, APIError> {
        provider.postData(endpoint: endpoint, bodyItem: cocktail)
    }
    
    func postSavedCocktail(cocktail: Encodable) -> AnyPublisher<PostResponse, APIError> {
        provider.postData(endpoint: endpoint, bodyItem: cocktail)
    }
}
