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
    func filterItem(itemCategory: String, itemList: [ItemPreview], completion: @escaping ([ItemPreview]) -> Void)
}

final class DefaultFilterItemUsecase: FilterItemUsecase {
    private let itemRepository: ItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var itemList: [ItemPreview] = []
    
    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func fetchItemList() -> AnyPublisher<ItemList, Error> {
        itemRepository.fetchIngredientList()
    }
    
    func filterItem(itemCategory: String, itemList: [ItemPreview], completion: @escaping ([ItemPreview]) -> Void) {
        if itemCategory == "전체" {
            completion(itemList)
        } else {
            let filteredItemList = itemList.filter { $0.category == itemCategory }
            completion(filteredItemList)
        }
    }
}
