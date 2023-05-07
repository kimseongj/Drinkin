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
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            print(httpURLResponse.statusCode)
            
            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }
        dataTask.resume()
    }
}

struct Provider1 {
    func fetchData<T: Decodable>(endpoint: EndpointMakeable, parser: Parser<T>, completion: @escaping (T) -> Void) {
        guard let request = endpoint.makeURLRequest() else { return }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 401 {
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else { return }
            
            print(httpURLResponse.statusCode)
            
            guard let validData = data, let parsedData = parser.parse(data: validData) else { return }
            completion(parsedData)
        }
        dataTask.resume()
    }
}

//class Provider2 {
//    
//    var cancelBag = Set<AnyCancellable>()
//    
//    func fetchData<T: Decodable> (endpoint: EndpointMakeable) -> AnyPublisher<T, HttpError> {
//        guard let urlRequest = endpoint.makeURLRequest() else { return }
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

struct Repository {

    func fetchPublisher<T: Decodable>(endpoint: EndpointMakeable, dataType: T) -> AnyPublisher<T, Error> {
        
        let urlRequest = endpoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest!).map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

class Repoistory {
    let repository = Repository()
    var subscriber: Set<AnyCancellable> = .init()
}
    
    //    func fetchDailyBoxOffice(completion: @escaping (DailyBoxOffice) -> Void) {
    //        repository.fetchPublisher(endpoint: <#EndpointMakeable#>, dataType: <#_#>).sink { completion in
    //            print("Rceived completion: \(completion)")
    //        } receiveValue: { dailyBoxOffice in
    //            completion(dailyBoxOffice)
    //        }.store(in: &subscriber)
    //    }
    //}
