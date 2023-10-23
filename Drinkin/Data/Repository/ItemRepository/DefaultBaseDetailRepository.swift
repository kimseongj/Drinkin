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
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchBaseDetail() -> AnyPublisher<BaseDetail, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
