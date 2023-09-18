//
//  CocktailFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol CocktailFilterRepository {
    func fetchPublisher() -> AnyPublisher<CocktailFilter, Error>
}

final class DefaultCocktailFilterRepository: CocktailFilterRepository {
    let provider = Provider()
    let endpoint = CocktailFilterEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailFilter, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
