//
//  BriefDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

class BriefDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<BriefDescription, Error> {
        let preferCocktailEndpoint = URL(string: "zczxc")
        
        return URLSession.shared.dataTaskPublisher(for: preferCocktailEndpoint!).map {
            $0.data
        }.decode(type: BriefDescription.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
