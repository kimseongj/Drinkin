//
//  IngredientFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct IngredientFilterEndpoint: EndpointMakeable {
    var baseURL: String = "https://19745220-e48f-4450-8fd8-097debb03b32.mock.pstmn.io"
    
    var path: String = "/ingredientfilter"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
