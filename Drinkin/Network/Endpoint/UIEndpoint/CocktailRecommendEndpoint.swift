//
//  CocktailRecommendEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/21.
//

import Foundation

struct CocktailRecommendEndpoint: EndpointMakeable {
    var baseURL: String = "https://061fc60f-2f6b-49ea-bac6-dc3055e4557f.mock.pstmn.io"
    
    var path: String = "/triedcocktail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
