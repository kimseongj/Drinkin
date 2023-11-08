//
//  CocktailFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

struct CocktailFilterEndpoint: EndpointMakeable {
    var baseURL: String = "https://7746e0bc-a34b-4f56-8a7b-10f954884482.mock.pstmn.io"
    
    var path: String = "/detailfilter"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
