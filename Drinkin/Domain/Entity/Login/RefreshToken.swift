//
//  RefreshToken.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/14.
//

import Foundation

struct RefreshToken: Codable {
    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}
