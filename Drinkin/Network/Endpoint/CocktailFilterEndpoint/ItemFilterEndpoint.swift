//
//  ItemFilterEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct ItemFilterEndpoint: EndpointMakeable {
    var baseURL: String = "https://891cacef-ef71-47f0-9c50-49bd59c3c879.mock.pstmn.io"

    var path: String = "/ingredientfilter"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
