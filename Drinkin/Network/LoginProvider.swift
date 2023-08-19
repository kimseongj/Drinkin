//
//  LoginProvider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

struct LoginProvider {
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
}

enum APIError: Error {
    case data
    case request
}
