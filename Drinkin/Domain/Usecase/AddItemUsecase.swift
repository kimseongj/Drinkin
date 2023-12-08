//
//  AddIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

protocol AddItemUsecase {
    func addItems(itemList: SelectedItemList) -> AnyPublisher<PostResponse, APIError>
}

final class DefaultAddItemUsecase: AddItemUsecase {
    private let additionRepository: AdditionRepository
    
    init(additionRepository: AdditionRepository) {
        self.additionRepository = additionRepository
    }
    
    func addItems(itemList: SelectedItemList) -> AnyPublisher<PostResponse, APIError> {
        return additionRepository.postHoldedItem(items: itemList)
    }
}
