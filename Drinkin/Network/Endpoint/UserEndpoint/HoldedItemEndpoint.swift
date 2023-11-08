//
//  HoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "https://bbda530f-79c1-48df-bee3-7d3e78c2e37f.mock.pstmn.io"
    
    var path: String = "/holdeditem"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
