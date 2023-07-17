//
//  Provider.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/04/14.
//

import Foundation
import Combine

struct Provider {
//    func fetchData<T: Decodable>(endpoint: EndpointMakeable, parser: Parser<T>, completion: @escaping (T) -> Void) {
//        guard let request = endpoint.makeURLRequest() else { return }
//
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else { return }
//
//            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
//                print(response)
//                return }
//
//            print(httpURLResponse.statusCode)
//
//            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
//            completion(parsedData)
//        }
//        dataTask.resume()
//    }
    
        func fetchData<T: Decodable>(endpoint: EndpointMakeable,
                                     parser: Parser<T>,
                                     completion: @escaping (T) -> Void) -> AnyPublisher<T, Error> {
            
            let request = endpoint.makeURLRequest()
                
                return URLSession.shared.dataTaskPublisher(for: request!).map {
                    $0.data
                }.decode(type: T.self, decoder: JSONDecoder())
                    .receive(on: RunLoop.main)
                    .eraseToAnyPublisher()
           
        }
    
//    func checkRequest(_ endpoint: EndpointMakeable) throws -> URLRequest {
//        guard let validEndpoint = endpoint.makeURLRequest() else { throw APIError.request }
//
//        return validEndpoint
//    }
//
//    func fetchPublisher() -> AnyPublisher<BriefDescription, Error> {
//        let preferCocktailEndpoint = URL(string: "zczxc")
//
//        return URLSession.shared.dataTaskPublisher(for: preferCocktailEndpoint!).map {
//            $0.data
//        }.decode(type: BriefDescription.self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//    }
    
}

enum APIError: Error {
    case data
    case request
}
//struct Provider1 {
//    let provider2 = Provider2()
//
//    func fetchData<T: Decodable>(endpoint: EndpointMakeable, parser: Parser<T>, completion: @escaping (T) -> Void) {
//        guard let request = endpoint.makeURLRequest() else { return }
//
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else { return }
//            
//            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 401 {
//                provider2.fetchData(endpoint: <#T##EndpointMakeable#>, refreshToken: <#T##String#>, parser: <#T##Parser<Decodable>#>, completion: <#T##(Decodable) -> Void#>)
//                return
//            }
//
//            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
//
//            print(httpURLResponse.statusCode)
//
//            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
//            completion(parsedData)
//        }
//        dataTask.resume()
//    }
//}

//struct Provider2 {
//    func fetchData<T: Decodable>(endpoint: EndpointMakeable, refreshToken: String, parser: Parser<T>, completion: @escaping (T) -> Void) {
//        guard let request = endpoint.makeURLRequest() else { return }
//
//        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard error == nil else { return }
//
//            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
//
//            print(httpURLResponse.statusCode)
//
//            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
//
//            completion(parsedData)
//        }
//        dataTask.resume()
//    }
//}

//class Provider2 {
//
//    var cancelBag = Set<AnyCancellable>()
//
//    func fetchData<T: Decodable> (endpoint: EndpointMakeable) -> AnyPublisher<T, Error> {
//        guard let urlRequest = endpoint.makeURLRequest() else { return }
//
//        URLSession.shared.dataTaskPublisher(for: urlRequest).map { $0.data }
//            .decode(type: T.self, decoder: JSONDecoder())
//            .mapError { error in
//                if let error = error as? HttpError {
//                    return error
//                } else {
//                    return HttpError.unknown
//                }
//            }
//            .eraseToAnyPublisher()
//    }
//}


    
    //    func fetchDailyBoxOffice(completion: @escaping (DailyBoxOffice) -> Void) {
    //        repository.fetchPublisher(endpoint: <#EndpointMakeable#>, dataType: <#_#>).sink { completion in
    //            print("Rceived completion: \(completion)")
    //        } receiveValue: { dailyBoxOffice in
    //            completion(dailyBoxOffice)
    //        }.store(in: &subscriber)
    //    }
    //}
