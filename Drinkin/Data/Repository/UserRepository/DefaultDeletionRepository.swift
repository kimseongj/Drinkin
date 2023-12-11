//
//  DefaultDeletionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/09.
//

import Foundation
import Combine

final class DefaultDeletionRepository: DeletionRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func delete(holdedItem: HoldedItem) -> AnyPublisher<PostResponse, APIError> {
        endpoint.insertQuery(queryParameter: "id", queryValue: String(holdedItem.id))
        endpoint.insertQuery(queryParameter: "type", queryValue: holdedItem.type)
        
        return provider.fetchData(endpoint: endpoint)
    }
}

