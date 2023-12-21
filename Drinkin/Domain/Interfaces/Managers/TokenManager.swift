//
//  TokenManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/20.
//

import Foundation

protocol TokenManager {
    func saveToken(tokenType: TokenType, token: String) throws
    func readToken(tokenType: TokenType) throws -> String?
    func updateToken(tokenType: TokenType, token: String) throws
    func deleteToken(tokenType: TokenType) throws
}
