//
//  IngredientFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol IngredientFilterRepository {
    func fetchIngredientFilter() -> AnyPublisher<IngredientFilter, Error>
}
