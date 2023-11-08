//
//  BaseBrandInformationEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

struct BaseBrandInformationEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/base_brands"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
