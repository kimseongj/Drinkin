//
//  RefreshEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct RefreshEndpoint: EndpointMakeable {
    var baseURL: String = "http://3.35.208.50"
    
    var path: String = "/v1/home"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
    
    mutating func insertAuthorization(accessToken: String) {
        header = ["Authorization": accessToken]
    }
}
