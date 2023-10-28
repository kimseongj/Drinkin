//
//  TriedCocktailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/18.
//

import Foundation

struct TriedCocktailEndpoint: EndpointMakeable {
    var baseURL: String = "https://d7ff6f27-d6fb-48ce-be4a-4f5ed33b511a.mock.pstmn.io"
    
    var path: String = "/triedcocktail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
