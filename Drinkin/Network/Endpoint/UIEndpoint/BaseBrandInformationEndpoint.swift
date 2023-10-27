//
//  BaseBrandInformationEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

struct BaseBrandInformationEndpoint: EndpointMakeable {
    var baseURL: String = "https://9a068c10-f6c1-4433-a241-431d589c8390.mock.pstmn.io"
    
    var path: String = "/brand"
    
    var method: String = HTTPMethod.get.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
