//
//  Provider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/19.
//

import Foundation
import Combine

struct Provider {
    let loginManager = LoginManager()
    
    func fetchData<T: Decodable>(endpoint: EndpointMakeable) -> AnyPublisher<T, Error> {
        let request = endpoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request!)
            .map {
                let httpResponse = $0.response as? HTTPURLResponse
                if httpResponse?.statusCode == 401 {
                    
                }
                
                return $0.data
            }
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
    
//    func fetchData<T: Decodable>(endpoint: EndpointMakeable) -> AnyPublisher<T, Error> {
//        var request = endpoint.makeURLRequest()
//        request?.setValue("Bearer \("newAccessToken.accessToken")", forHTTPHeaderField: "Authorization")
//        
//        return URLSession.shared.dataTaskPublisher(for: request!)
//            .tryMap { data, response in
//                let httpResponse = response as! HTTPURLResponse
//                if httpResponse.statusCode == 401 {
//                    throw APIError.unauthorized
//                }
//                return data
//            }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .catch { error in
//                if let apiError = error as? APIError, apiError == .unauthorized {
//                    // Renew the AccessToken
//                    return loginManager.renewAccessTokenPublisher()
//                        .flatMap { newAccessToken in
//                            
//                            var newRequest = request
//                            newRequest!.setValue("Bearer \(newAccessToken.accessToken)", forHTTPHeaderField: "Authorization")
//                            
//                            // Make the API call with the renewed AccessToken
//                            return URLSession.shared.dataTaskPublisher(for: newRequest!)
//                                .map(\.data)
//                                .decode(type: T.self, decoder: JSONDecoder())
//                        }
//                        .eraseToAnyPublisher()
//                }
//                return Fail(error: error)
//                    .eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
//    }
}
