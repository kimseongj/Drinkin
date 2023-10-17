//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol IngredientRepository {
    func fetchIngredientList() -> AnyPublisher<IngredientDescription, Error>
    func postIngredientList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error>
}
