//
//  asdasd.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct LoginToken: Codable {
    let accessToken: String
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
