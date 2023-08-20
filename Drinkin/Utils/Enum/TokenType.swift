//
//  TokenType.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/19.
//

import Foundation

enum TokenType {
    case accessToken
    case refreshToken
    
    var description: String {
        switch self {
        case .accessToken:
            return "accessToken"
        case .refreshToken:
            return "refreshToken"
        }
    }
}
