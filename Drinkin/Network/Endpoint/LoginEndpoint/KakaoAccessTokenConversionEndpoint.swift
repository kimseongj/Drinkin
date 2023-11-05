//
//  LoginEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct KakaoAccessTokenConversionEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"

    var path: String = "/v1/kakao-login"

    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
