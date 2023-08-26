//
//  TriedCocktailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol TriedCocktailRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

class DefaultTriedCocktailRepository: TriedCocktailRepository {
    let provider = Provider()
    let endpoint = TriedCocktailEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
