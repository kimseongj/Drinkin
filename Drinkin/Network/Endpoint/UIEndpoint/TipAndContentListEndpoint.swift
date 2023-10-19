//
//  TipAndContentListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

struct TipAndContentListEndpoint: EndpointMakeable {
    var baseURL: String = "https://6cc5c08a-c519-4c91-b46b-9b63383f9e91.mock.pstmn.io"
    
    var path: String = "/tip"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
}
