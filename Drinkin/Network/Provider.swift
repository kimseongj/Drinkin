//
//  Provider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

struct Provider {
    func fetchData<T: Decodable>(endpoint: EndpointMakeable, parser: Parser<T>, completion: @escaping (T) -> Void) {
        guard let request = endpoint.makeURLRequest() else { return }

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }

            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
                print(response)
                return }

            print(httpURLResponse.statusCode)

            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }
        dataTask.resume()
    }
    
    func fetchData1<T: Decodable>(endpoint: EndpointMakeable)  -> AnyPublisher<T, Error> {
        let request = endpoint.makeURLRequest()

        return URLSession.shared.dataTaskPublisher(for: request!)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

enum APIError: Error {
    case data
    case request
}
