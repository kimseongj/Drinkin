//
//  KeychainManager.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/18.
//

import Foundation

struct TokenCredentials {
    var tokenType: String
    var token: String
}

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

enum KeychainError: Error {
    case noPassword
    case duplicateItem
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

class KeychainManager {
    func saveToken(tokenType: TokenType, token: String) throws {
        let account = tokenType.description
        guard let password = token.data(using: String.Encoding.utf8) else { return } //오류처리 필요
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: password
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func readToken(tokenType: TokenType) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecAttrAccount as String: tokenType,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        
        guard let existingItem = item as? [String: Any],
              let token = existingItem[kSecValueData as String] as? String else { return nil }
              
        return token
    }
    
    func updateToken(tokenType: TokenType, token: String) throws {
        let account = tokenType.description
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]
        
        let password = token.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecValueData as String: password]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func deleteToken(tokenType: TokenType) throws {
        let account = tokenType.description
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
}
