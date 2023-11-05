//
//  DefaultGlassDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

final class DefaultGlassDetailRepository: GlassDetailRepository {
    let glassID: Int
    let provider = Provider()
    var endpoint: EndpointMakeable = GlassDetailEndpoint()
    
    init(glassID: Int) {
        self.glassID = glassID
    }
    
    func fetchGlassDetail() -> AnyPublisher<GlassDetail, Error> {
        endpoint.insertPathParmeter(pathParameter: glassID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
