//
//  CocktailRecommendEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/21.
//

import Foundation

struct CocktailRecommendEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    //https://26c37157-901c-45c9-ba1c-d5956387f26a.mock.pstmn.io
    var path: String = "/v1/home"
    // /recommendcocktail
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
