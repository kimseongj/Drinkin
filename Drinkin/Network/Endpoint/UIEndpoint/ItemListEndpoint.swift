//
//  ItemListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation

struct ItemListEndpoint: EndpointMakeable {
    var baseURL: String = ""
    
    var path: String = ""
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
