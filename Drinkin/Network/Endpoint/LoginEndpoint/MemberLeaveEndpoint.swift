//
//  MemberLeaveEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2024/01/05.
//

import Foundation

struct MemberLeaveEndpoint: EndpointMakeable {
    var baseURL: String = "http://13.209.22.43:8000"
    
    var path: String = "/v1/withdraw"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
