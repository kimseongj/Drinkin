//
//  asdasd.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/16.
//

import Foundation

struct LoginToken: Decodable {
    let accessToken: String
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

struct RefreshToken: Decodable {
    let userID: Int
    let detail: String
    
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case detail
    }
}

struct asdasdasdasd: Decodable {
    let detail: String
    
    private enum CodingKeys: String, CodingKey {
        case detail = "detail"
    }
}
