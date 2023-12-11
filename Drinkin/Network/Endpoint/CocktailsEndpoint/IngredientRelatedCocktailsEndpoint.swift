//
//  IngredientRelatedCocktailsEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/11.
//

import Foundation

struct IngredientRelatedCocktailsEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/ingredient-related-cocktails"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
