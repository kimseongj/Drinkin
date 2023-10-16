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
    
    mutating func insertPathParmeter(pathParameter: String)
    mutating func insertQuery(queryParameter: String, queryValue: String)
    mutating func removeQuery(queryParamter: String)
    mutating func removeAllQuery()
    
    func makeURL() -> URL?
    func makeURLRequest() -> URLRequest?
    func makeJsonPostRequest<T: Encodable>(endPoint: EndpointMakeable, bodyItem: T) -> URLRequest?
}

extension EndpointMakeable {
    mutating func insertPathParmeter(pathParameter: String) {
        path += "/\(pathParameter)"
    }
    
    mutating func insertQuery(queryParameter: String, queryValue: String) {
        queryItems.append(URLQueryItem(name: queryParameter, value: queryValue))
    }
    
    mutating func removeQuery(queryParamter: String) {
       queryItems = queryItems.filter {
            $0.name != queryParamter
        }
    }
    
    mutating func removeAllQuery() {
        queryItems = []
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
    
    func makeJsonPostRequest<T: Encodable>(endPoint: EndpointMakeable, bodyItem: T) -> URLRequest? {
        guard var request = makeURLRequest() else { return nil }
        let requestBody = bodyItem
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            print("PostError")
        }
        
        return request
    }
}
