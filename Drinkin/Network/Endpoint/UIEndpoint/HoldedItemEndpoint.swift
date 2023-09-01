//
//  HoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "https://23e125b1-7ec7-4379-9a46-03454b2ac212.mock.pstmn.io"
    
    var path: String = "/holdeditem"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
