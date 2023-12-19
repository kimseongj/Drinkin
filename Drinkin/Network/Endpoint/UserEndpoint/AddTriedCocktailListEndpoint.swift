//
//  AddTriedCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation

struct AddTriedCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/tried-cocktails"
                        
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
