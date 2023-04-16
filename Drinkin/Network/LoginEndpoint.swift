//
//  LoginEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct LoginEndpoint: EndpointMakeable {
    var baseURL: String = "http://3.35.208.50"
    
    var path: String = "/v1/kakao-login"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
    
    mutating func insertTokenQueryValue(token: String) {
        queryItems.append(URLQueryItem(name: "access_token", value: token))
    }
}
