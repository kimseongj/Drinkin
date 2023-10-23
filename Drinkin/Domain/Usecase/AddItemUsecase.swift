//
//  AddIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

protocol AddItemUsecase {
    func addItem(itemList: [String]) -> AnyPublisher<HoldedItem, Error>
}

final class DefaultAddItemUsecase: AddItemUsecase {
    private let itemRepository: ItemRepository
    
    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func addItem(itemList: [String]) -> AnyPublisher<HoldedItem, Error> {
        return itemRepository.postIngredientList(receipeItems: itemList)
    }
}
