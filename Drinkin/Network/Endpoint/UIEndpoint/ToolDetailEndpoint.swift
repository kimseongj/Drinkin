//
//  ToolDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

struct ToolDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://d8cc916e-b342-463c-be50-e3c74be7d478.mock.pstmn.io"
    
    var path: String = "/tool"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
