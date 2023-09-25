//
//  FirstLogin.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

//MARK: - FirstLogin
struct FirstLogin: Codable {
    let accessToken: String
    let holdedItemList: [Int]
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case holdedItemList = "preferred_cocktails"
    }
}
