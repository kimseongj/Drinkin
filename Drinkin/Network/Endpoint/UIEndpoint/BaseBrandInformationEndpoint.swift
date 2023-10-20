//
//  BaseBrandInformationEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

struct BaseBrandInformationEndpoint: EndpointMakeable {
    var baseURL: String = "https://41b9e562-5f0b-4f0c-98ab-3e657e0e7dea.mock.pstmn.io"
    
    var path: String = "/brand"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
