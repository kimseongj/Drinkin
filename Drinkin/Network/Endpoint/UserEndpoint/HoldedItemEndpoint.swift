//
//  HoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/holded-item"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
