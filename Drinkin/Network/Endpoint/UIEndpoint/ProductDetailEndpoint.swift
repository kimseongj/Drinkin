//
//  ProductDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

struct ProductDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://0c7e142f-aece-44f5-857c-f313df9c6f7b.mock.pstmn.io"
    
    var path: String = ""
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
    
    mutating func insertPathParmeter(id: Int) {
        //path = "/v1/cocktails/\(id)"
        path = "/10"
    }
}
