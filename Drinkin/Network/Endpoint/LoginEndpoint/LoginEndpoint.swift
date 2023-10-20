//
//  LoginEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct AccessTokenConversionEndpoint: EndpointMakeable {
    var baseURL: String = "https://ed41530a-7b99-47dd-99eb-54ef60188c0f.mock.pstmn.io"

    var path: String = "/firstlogin"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
