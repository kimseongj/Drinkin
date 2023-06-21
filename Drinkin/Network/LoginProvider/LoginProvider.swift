//
//  LoginProvider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/05.
//

import Foundation
import Combine

struct LoginProvider {
//    func convertAccessToken<T: Decodable>(endpoint: EndpointMakeable, completion: @escaping (T) -> Void) -> AnyPublisher<T, Error>? {
//        guard let request = endpoint.makeURLRequest() else { return nil }
//            
//            return  URLSession.shared
//                .dataTaskPublisher(for: request)
//                .tryMap() { data, response in
//                    guard let httpResponse = response as? HTTPURLResponse else {
//                        print("응답 오류")
//                        return
//                        //                    throw HttpError.unknown
//                    }
//
//                    guard 200..<300 ~= httpResponse.statusCode else {
//                        //                    throw HttpError.httpStatusError(httpResponse.statusCode, httpResponse.description)
//                        return
//                    }
//
//                    guard !data.isEmpty else {
//                        //                    throw HttpError.unknown
//                        return
//                    }
//
//                    return data
//                }
//                .decode(type: T.self, decoder: JSONDecoder()).eraseToAnyPublisher()
//        }
}

struct Repository {
//    func fetchPublisher(endpoint: EndpointMakeable) -> AnyPublisher<LoginToken, Error> {
//
//        let urlRequest = endpoint.makeURLRequest()
//
//        return URLSession.shared.dataTaskPublisher(for: urlRequest!).tryMap { $0.data }
//            .decode(type: LoginToken.self, decoder: JSONDecoder()).eraseToAnyPublisher()
//
//    }
}

class Repoistory {
    let repository = Repository()
    var subscriber: Set<AnyCancellable> = .init()
}
