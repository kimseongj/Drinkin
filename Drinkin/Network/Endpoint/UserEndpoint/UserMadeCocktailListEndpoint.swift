//
//  UserMadeCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation

struct UserMadeCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/made-cocktails"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
