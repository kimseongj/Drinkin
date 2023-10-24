//
//  FilterIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation
import Combine

protocol FilterItemUsecase {
    func fetchItemList() -> AnyPublisher<ItemList, Error>
    func filterItem(itemCategory: String, completion: @escaping ([ItemPreview]) -> Void)
}

final class DefaultFilterItemUsecase: FilterItemUsecase {
    private let itemRepository: ItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func fetchItemList() -> AnyPublisher<ItemList, Error> {
        return itemRepository.fetchIngredientList()
    }
    
    func filterItem(itemCategory: String, completion: @escaping ([ItemPreview]) -> Void) {
        itemRepository.fetchIngredientList().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            var filteredItemList: [ItemPreview] = []
            
            if itemCategory == "전체" {
                filteredItemList = $0.itemList
            } else {
                filteredItemList = $0.itemList.filter { $0.category == itemCategory }
            }
            
            completion(filteredItemList)
        }).store(in: &cancelBag)
    }
}
