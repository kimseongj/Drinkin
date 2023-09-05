//
//  FirstLogin.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

struct FirstLogin: Codable {
    let accessToken: String
    let holdedItemList: [Int]
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case holdedItemList = "preferred_cocktails"
    }
}

struct FirstLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
