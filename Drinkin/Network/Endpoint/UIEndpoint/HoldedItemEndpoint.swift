//
//  HoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "https://8e298973-e1f6-45d5-8a0c-5590ab8b3ba2.mock.pstmn.io"
    
    var path: String = "/holdeditem"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
