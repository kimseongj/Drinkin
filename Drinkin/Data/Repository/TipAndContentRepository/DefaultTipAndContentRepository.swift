//
//  DefaultTipAndContentRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

final class DefaultTipAndContentRepository: TipAndContentRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }

    func fetchtTipAndContentList() -> AnyPublisher<TipAndContentList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
