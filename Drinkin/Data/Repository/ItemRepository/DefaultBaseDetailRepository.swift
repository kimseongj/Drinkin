//
//  DefaultBaseDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation
import Combine

final class DefaultBaseDetailRepository: BaseDetailRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let baseID: Int
    
    init(provider: Provider, endpoint: EndpointMakeable, baseID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.baseID = baseID
    }
    
    func fetchBaseDetail() -> AnyPublisher<BaseDetail, APIError> {
        endpoint.insertPathParmeter(pathParameter: baseID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
