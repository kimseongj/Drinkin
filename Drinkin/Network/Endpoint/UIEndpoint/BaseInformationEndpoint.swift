//
//  BaseInformationEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/06.
//

import Foundation

struct BaseInformationEndpoint: EndpointMakeable {
    var baseURL: String = "https://728d14f2-0d46-4b9f-96e9-71ea40d737f0.mock.pstmn.io"
    
    var path: String = "/base"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
