//
//  TriedCocktailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/18.
//

import Foundation

struct TriedCocktailEndpoint: EndpointMakeable {
    var baseURL: String = "https://e0300af8-1756-4713-8b6d-903e44c3c78d.mock.pstmn.io"
    
    var path: String = "/triedcocktail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
//https://e0300af8-1756-4713-8b6d-903e44c3c78d.mock.pstmn.io
