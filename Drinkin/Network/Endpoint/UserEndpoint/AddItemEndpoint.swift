//
//  AddItemEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation

struct AddItemEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/update-hold-item"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
