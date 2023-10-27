//
//  ProductDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

struct ProductDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://c5260079-5391-4802-b98a-4d146a533121.mock.pstmn.io"
    
    var path: String = "/productdetail"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
