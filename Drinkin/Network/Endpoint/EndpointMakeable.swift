//
//  EndpointMakeable.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/04.
//

import Foundation

protocol EndpointMakeable {
    var baseURL: String { get }
    var path: String { get set }
    var method: String { get }
    var queryItems: [URLQueryItem] { get set }
    var header: [String: String]? { get }
    
    func makeURL() -> URL?
    func makeURLRequest() -> URLRequest?
    mutating func insertPathParmeter(pathParameter: String)
    mutating func insertQuery(queryParameter: String, queryValue: String)
}

extension EndpointMakeable {
    mutating func insertPathParmeter(pathParameter: String) {
        path += "/\(pathParameter)"
    }
    
    mutating func insertQuery(queryParameter: String, queryValue: String) {
        queryItems.append(URLQueryItem(name: queryParameter, value: queryValue))
    }
    
    func makeURL() -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else { return nil }
        
        return url
    }
    
    func makeURLRequest() -> URLRequest? {
        guard let url = makeURL() else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        header?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        
        return urlRequest
    }
}
