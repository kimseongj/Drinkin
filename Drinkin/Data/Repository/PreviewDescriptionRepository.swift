//
//  PreviewDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol PreviewDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultPreviewDescriptionRepository: PreviewDescriptionRepository {
    let tokenManager: TokenManager
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
