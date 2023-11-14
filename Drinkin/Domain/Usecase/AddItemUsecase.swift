//
//  AddIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

protocol AddItemUsecase {
    func addItems(itemList: [String]) -> AnyPublisher<HoldedItem, Error>
}

final class DefaultAddItemUsecase: AddItemUsecase {
    private let additionRepository: AdditionRepository
    
    init(additionRepository: AdditionRepository) {
        self.additionRepository = additionRepository
    }
    
    func addItems(itemList: [String]) -> AnyPublisher<HoldedItem, Error> {
        return additionRepository.postHoldedItem(items: itemList)
    }
}
