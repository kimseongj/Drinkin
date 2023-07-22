//
//  MockEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/21.
//

import Foundation

struct MockEndpoint: EndpointMakeable {
    var baseURL: String = "http://192.168.0.16/"
    
    var path: String = "/v1/home"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
