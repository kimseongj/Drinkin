//
//  CocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "https://9370ab1e-4838-4db0-85fb-8f3bb967155c.mock.pstmn.io"
    
    var path: String = "/cocktaillist"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
