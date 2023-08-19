//
//  KeyChainError.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/19.
//

import Foundation

enum KeychainError: Error {
    case noPassword
    case duplicateItem
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}
