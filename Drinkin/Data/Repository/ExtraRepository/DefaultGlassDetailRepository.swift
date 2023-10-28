//
//  DefaultGlassDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

final class DefaultGlassDetailRepository: GlassDetailRepository {
    let glassID: Int
    var endpoint: EndpointMakeable = GlassDetailEndpoint()
    
    init(glassID: Int) {
        self.glassID = glassID
    }
    
    func fetchGlassDetail() {
        //endpoint.insertQuery(queryParameter: "id", queryValue: toolID.description)
    }
}
