//
//  RenewAccessTokenEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/03.
//

import Foundation

struct RenewAccessTokenEndpoint: EndpointMakeable {
    var baseURL: String = ""
    
    var path: String = ""
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
