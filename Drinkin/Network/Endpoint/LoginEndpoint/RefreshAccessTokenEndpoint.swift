//
//  RefreshAccessTokenEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/26.
//

import Foundation

struct RefreshAccessTokenEndpoint: EndpointMakeable {
    var baseURL: String = "http://3.35.208.50"
    
    var path: String = "/v1/refresh-token"

    var method: String
    
    var queryItems: [URLQueryItem]
    
    var header: [String : String] = [:]
    
    mutating func insertTokenQueryValue(refreshToken: String) {
        queryItems.append(URLQueryItem(name: "refresh_token", value: refreshToken))
    }
}
