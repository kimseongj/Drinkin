//
//  ItemFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct ItemFilterEndpoint: EndpointMakeable {
    var baseURL: String = "https://b3cef313-8e32-4e5b-bd58-48adc35e6e6f.mock.pstmn.io"

    var path: String = "/itemfilter"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
