//
//  DefaultToolDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

final class DefaultToolDetailRepository: ToolDetailRepository {
    let provider = DefaultProvider()
    var endpoint: EndpointMakeable = ToolDetailEndpoint()
    let toolID: Int
    
    init(toolID: Int) {
        self.toolID = toolID
    }
    
    func fetchToolDetail() -> AnyPublisher<ToolDetail, Error> {
        endpoint.insertPathParmeter(pathParameter: toolID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
