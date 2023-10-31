//
//  CocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/cocktails"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
