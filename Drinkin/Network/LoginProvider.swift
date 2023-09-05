//
//  LoginProvider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

struct LoginProvider {
    private var cancelBag: Set<AnyCancellable> = []
    
    func fetchData<T: Decodable>(endpoint: EndpointMakeable, parser: Parser<T>, completion: @escaping (T) -> Void) {
        guard var request = endpoint.makeURLRequest() else { return }
        if endpoint.method == "POST" {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

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
    
    func makePostRequest(endpoint: EndpointMakeable, accessToken: String, holdedCocktailList: [Int]) -> URLRequest? {
        guard var request = endpoint.makeURLRequest() else { return nil }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = FirstLogin(accessToken: accessToken, holdedItemList: holdedCocktailList)
        
        do {
            request.httpBody = try JSONEncoder().encode(requestBody)
        } catch {
            print("PostError")
        }
        
        return request
    }
    
    mutating func postAccessTokenAndHoldedItem(request: URLRequest?) {
        guard let request else { return }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data).decode(type: FirstLoginResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }, receiveValue: {
                print($0)
            }).store(in: &cancelBag)
    }
}

enum APIError: Error {
    case data
    case request
}
