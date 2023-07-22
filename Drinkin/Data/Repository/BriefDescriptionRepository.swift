//
//  BriefDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

class BriefDescriptionRepository {
    let provider = Provider()
    let endPoint = MockEndpoint()
    
    func fetchPublisher() -> AnyPublisher<BriefDescription, Error> {
        let endPoint = MockEndpoint()
        let request = endPoint.makeURLRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request!).map {
            $0.data
        }.decode(type: BriefDescription.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
