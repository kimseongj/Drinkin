//
//  ProductDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

//struct ProductDetailEndpoint: EndpointMakeable {
//    var baseURL: String = "https://0c7e142f-aece-44f5-857c-f313df9c6f7b.mock.pstmn.io"
//
//    var path: String = ""
//
//    var method: String = HTTPMethod.get.rawValue
//
//    var queryItems: [URLQueryItem] = []
//
//    var header: [String : String]?
//
//    mutating func insertPathParmeter(id: Int) {
//        //path = "/cocktail/\(id)"
//        path = "/10"
//    }
//}


//http://192.168.0.9/v1/cocktails/10

struct ProductDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://62ddf533-c23b-44b9-8a6d-54cef16fcd97.mock.pstmn.io"
    
    var path: String = ""
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String]?
    
    mutating func insertPathParmeter(id: Int) {
        //path = "/v1/cocktails/\(id)"
        path = "/10"
    }
}