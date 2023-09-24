//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol IngredientFilterRepository {
    func fetchPublisher() -> AnyPublisher<IngredientFilter, Error>
}

final class DefaultIngredientFilterRepository: IngredientFilterRepository {
    let provider = Provider()
    let endpoint = IngredientFilterEndpoint()
    
    func fetchPublisher() -> AnyPublisher<IngredientFilter, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
