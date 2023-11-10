//
//  AddTriedCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation

struct AddTriedCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "https://dcf60fad-ecb5-47f4-ad0b-fd8858f17237.mock.pstmn.io"
    
    var path: String = "/triedcocktail"
                        
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
