//
//  BaseInformationEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import Foundation

struct BaseInformationEndpoint: EndpointMakeable {
    var baseURL: String = "https://42c8642a-73d1-423e-b15a-3abf58495901.mock.pstmn.io"
    
    var path: String = "/base"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
