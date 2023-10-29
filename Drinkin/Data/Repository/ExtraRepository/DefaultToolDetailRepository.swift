//
//  DefaultToolDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

final class DefaultToolDetailRepository: ToolDetailRepository {
    let toolID: Int
    let provider = Provider()
    var endpoint: EndpointMakeable = ToolDetailEndpoint()
    
    init(toolID: Int) {
        self.toolID = toolID
    }
    
    func fetchToolDetail() -> AnyPublisher<ToolDetail, Error> {
        //endpoint.insertQuery(queryParameter: "id", queryValue: toolID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
