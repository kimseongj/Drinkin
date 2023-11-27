//
//  RenewAccessTokenEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/03.
//

import Foundation

struct RenewAccessTokenEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/refresh-token"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
