//
//  FirstLoginResponse.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/26.
//

import Foundation

//MARK: - FirstLoginResponse
struct FirstLoginResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
