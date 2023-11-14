//
//  DefaultAdditionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation
import Combine

final class DefaultAdditionRepository: AdditionRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func postTriedCocktail(cocktailIDList: CocktailIDList) -> AnyPublisher<PostResponse, Error> {
        return provider.postData(endpoint: endpoint, bodyItem: cocktailIDList)
    }
    
    func postHoldedItem(items: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return provider.postData(endpoint: endpoint, bodyItem: items)
    }
}
