//
//  AccessToken.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/03.
//

import Foundation

struct AccessToken: Codable {
    let accessToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
