//
//  ItemListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation

struct ItemListEndpoint: EndpointMakeable {
    var baseURL: String = "https://32e7f79c-3b44-4fc1-a3f1-6332dabc37b4.mock.pstmn.io"

    var path: String = "/itemlist"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
