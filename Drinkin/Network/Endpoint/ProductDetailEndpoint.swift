//
//  ProductDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

struct ProductDetailEndpoint: EndpointMakeable {
    var baseURL: String = "http://192.168.0.9/v1"
    
    var path: String = ""
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
    
    mutating func insertPathParmeter(id: Int) {
        path = "/cocktail/\(id)"
    }
}
