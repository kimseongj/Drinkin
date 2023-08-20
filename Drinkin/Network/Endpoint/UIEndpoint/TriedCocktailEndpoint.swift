//
//  TriedCocktailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/18.
//

import Foundation

struct TriedCocktailEndpoint: EndpointMakeable {
    var baseURL: String = "https://1fcd7cf3-4d04-4ca6-8446-419a2f7686aa.mock.pstmn.io"
    
    var path: String = "triedcocktail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
