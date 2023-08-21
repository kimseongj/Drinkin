//
//  TriedCocktailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol TriedCocktailRepository {
    func fetchPublisher() -> AnyPublisher<TriedCocktail, Error>
}

class DefaultTriedCocktailRepository: TriedCocktailRepository {
    let provider = Provider()
    let endpoint = CocktailRecommendEndpoint()
    
    func fetchPublisher() -> AnyPublisher<TriedCocktail, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
