//
//  BookmarkCocktailListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

struct BookmarkCocktailListEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/bookmark-cocktails"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
