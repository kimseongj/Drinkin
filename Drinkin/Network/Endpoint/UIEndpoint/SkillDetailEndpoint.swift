//
//  SkillDetailEndpoint.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

struct SkillDetailEndpoint: EndpointMakeable {
    var baseURL: String = "https://f9fe0bca-e12e-4c39-a000-d0fc7ad216de.mock.pstmn.io"
    
    var path: String = "/skill"
    
    var method: String = HTTPMethod.post.rawValue
    
    var queryItems: [URLQueryItem] = []
    
    var header: [String : String] = [:]
}
