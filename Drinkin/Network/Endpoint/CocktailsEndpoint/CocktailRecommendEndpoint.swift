//
//  CocktailRecommendEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/21.
//

import Foundation

struct CocktailRecommendEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"

    var path: String = "/v1/home"

    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
