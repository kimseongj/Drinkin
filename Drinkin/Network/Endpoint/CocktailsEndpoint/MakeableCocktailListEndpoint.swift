//
//  MakeableCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/12.
//

import Foundation

struct MakeableCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "https://e2071188-0508-48be-85bd-321a53477ca0.mock.pstmn.io"
    
    var path: String = "/cocktail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
