//
//  DefaultGlassDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

final class DefaultGlassDetailRepository: GlassDetailRepository {
    let provider = DefaultProvider(tokenManager: DefaultTokenManager())
    var endpoint: EndpointMakeable = GlassDetailEndpoint()
    let glassID: Int
    
    init(glassID: Int) {
        self.glassID = glassID
    }
    
    func fetchGlassDetail() -> AnyPublisher<GlassDetail, APIError> {
        endpoint.insertPathParmeter(pathParameter: glassID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
