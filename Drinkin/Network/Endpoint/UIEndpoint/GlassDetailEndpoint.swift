//
//  GlassDetailEndpoin.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

struct GlassDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://e8ad22a5-1b86-4e21-a602-36c3988250c6.mock.pstmn.io"
    
    var path: String = "/glass"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
