//
//  IngredientRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol ItemRepository {
    func fetchItemData() -> AnyPublisher<ItemSelectionList, APIError>
}
