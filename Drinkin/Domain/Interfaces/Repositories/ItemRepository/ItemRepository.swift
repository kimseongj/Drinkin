//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol ItemRepository {
    func fetchItemList() -> AnyPublisher<ItemList, Error>
    func postItemList(receipeItems: Encodable) -> AnyPublisher<HoldedItem, Error>
}
