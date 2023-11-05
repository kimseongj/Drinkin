//
//  DefaultBaseDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation
import Combine

final class DefaultBaseDetailRepository: BaseDetailRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    let baseID: Int
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable, baseID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.baseID = baseID
    }
    
    func fetchBaseDetail() -> AnyPublisher<BaseDetail, Error> {
        endpoint.insertPathParmeter(pathParameter: baseID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
