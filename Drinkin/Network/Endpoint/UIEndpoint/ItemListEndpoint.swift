//
//  ItemListEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation

struct ItemListEndpoint: EndpointMakeable {
    var baseURL: String = "https://1e10ad7d-7845-4433-aa0c-b658bf7d2078.mock.pstmn.io"

    var path: String = "/ingredient"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
