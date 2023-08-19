//
//  12312312Endpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

//http://3.35.208.50/v1/refresh-token?refresh_token={}
struct RefreshAccessTokenEndpoint: EndpointMakeable {
    var baseURL: String = "http://3.35.208.50"
    
    var path: String = "/v1/refresh-token"

    var method: String
    
    var queryItems: [URLQueryItem]
    
    var header: [String : String]?
    
    mutating func insertTokenQueryValue(refreshToken: String) {
        queryItems.append(URLQueryItem(name: "refresh_token", value: refreshToken))
    }
}
