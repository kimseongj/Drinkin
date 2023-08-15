//
//  LoginEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

//MARK: - Convert kakao login token to Drinkin login token
struct AccessTokenConversionEndpoint: EndpointMakeable {
    var baseURL: String = "http://172.29.65.78:8000"

    var path: String = "/v1/kakao-login"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
    
    mutating func insertTokenQueryValue(accessToken: String) {
        queryItems.append(URLQueryItem(name: "access_token", value: accessToken))
    }
}
