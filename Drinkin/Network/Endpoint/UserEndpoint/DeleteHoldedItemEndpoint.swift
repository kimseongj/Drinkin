//
//  DeleteHoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/09.
//

import Foundation

struct DeleteHoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/delete-holded-item"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
