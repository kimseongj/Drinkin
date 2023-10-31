//
//  IngredientDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation

struct IngredientDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://5f201595-24ab-49a4-b757-be85c091203c.mock.pstmn.io"
    
    var path: String = "/itemdetail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
