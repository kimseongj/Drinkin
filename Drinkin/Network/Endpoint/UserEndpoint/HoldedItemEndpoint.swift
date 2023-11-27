//
//  HoldedItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemEndpoint: EndpointMakeable {
    var baseURL: String = "https://7ebea399-2cd6-4172-8337-8a1dec11b1df.mock.pstmn.io"
    
    var path: String = "/holdeditem"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
