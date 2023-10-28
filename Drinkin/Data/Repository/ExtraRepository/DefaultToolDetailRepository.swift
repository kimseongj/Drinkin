//
//  DefaultToolDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

final class DefaultToolDetailRepository: ToolDetailRepository {
    let toolID: Int
    var endpoint: EndpointMakeable = ToolDetailEndpoint()
    
    init(toolID: Int) {
        self.toolID = toolID
    }
    
    func fetchToolDetail() {
        //endpoint.insertQuery(queryParameter: "id", queryValue: toolID.description)
    }
}
