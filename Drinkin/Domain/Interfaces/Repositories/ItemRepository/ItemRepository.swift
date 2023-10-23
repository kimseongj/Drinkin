//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol ItemRepository {
    func fetchIngredientList() -> AnyPublisher<ItemList, Error>
    func postIngredientList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error>
}
