//
//  CocktailFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailFilterEndpoint: EndpointMakeable {
    var baseURL: String = "https://d874398d-d962-4bd9-ab19-8e607cef373f.mock.pstmn.io"
    
    var path: String = "/filter"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
