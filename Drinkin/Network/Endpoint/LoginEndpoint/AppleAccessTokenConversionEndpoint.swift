//
//  AppleAccessTokenConversionEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/05.
//

import Foundation

struct AppleAccessTokenConversionEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"

    var path: String = "/v1/apple-login"

    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
