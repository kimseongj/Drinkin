//
//  ItemSelectionEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation

struct ItemSelectionEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"

    var path: String = "/v1/add-item-page"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
