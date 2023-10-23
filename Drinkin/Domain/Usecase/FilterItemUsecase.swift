//
//  FilterIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation
import Combine

protocol FilterItemUsecase {
    func filterItem(itemCategory: String, completion: @escaping ([ItemDetail]) -> Void)
}

final class DefaultFilterItemUsecase: FilterItemUsecase {
    private let itemRepository: ItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func filterItem(itemCategory: String, completion: @escaping ([ItemDetail]) -> Void) {
        itemRepository.fetchIngredientList().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            let filteredItemList = $0.itemList.filter { $0.ingredientCategory == itemCategory }
            
            completion(filteredItemList)
        }).store(in: &cancelBag)
    }
}
