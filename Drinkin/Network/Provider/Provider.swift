//
//  Provider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/19.
//

import Foundation
import Combine

struct Provider {
    func fetchData<T: Decodable>(endpoint: EndpointMakeable) -> AnyPublisher<T, Error> {
        let request = endpoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func postData<B: Encodable, T: Decodable>(endpoint: EndpointMakeable, bodyItem: B) -> AnyPublisher<T, Error> {
        let request = endpoint.makeJsonPostRequest(endPoint: endpoint, bodyItem: bodyItem)
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
