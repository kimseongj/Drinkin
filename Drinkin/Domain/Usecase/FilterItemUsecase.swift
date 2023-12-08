//
//  FilterIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation
import Combine

protocol FilterItemUsecase {
    func fetchItemData() -> AnyPublisher<ItemSelectionList, APIError>
    func filterItem(itemCategory: String,
                    itemList: [Item]) -> [Item]
}

final class DefaultFilterItemUsecase: FilterItemUsecase {
    private let itemRepository: ItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var itemList: [Item] = []
    
    init(itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func fetchItemData() -> AnyPublisher<ItemSelectionList, APIError> {
        itemRepository.fetchItemData()
    }
    
    func filterItem(itemCategory: String,
                    itemList: [Item]) -> [Item] {
        if itemCategory == "whole" {
            return itemList
        } else {
            let filteredItemList = itemList.filter { $0.subType == itemCategory }
            return filteredItemList
        }
    }
}
