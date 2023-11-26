//
//  CocktailFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailFilterEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/filters"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
