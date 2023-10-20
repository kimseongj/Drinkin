//
//  CocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "https://19fdd04c-1102-4b20-b18b-37ca653fa0da.mock.pstmn.io"
    
    var path: String = "/cocktaillist"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
