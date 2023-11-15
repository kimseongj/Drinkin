//
//  APIError.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/26.
//

import Foundation

enum APIError: Error {
    case decodingError
    case unauthorized
    case notFound
    case refreshTokenExpired
    case networkError(Error)
}
