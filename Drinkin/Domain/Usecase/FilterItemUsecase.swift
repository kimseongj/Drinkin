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
                    itemList: [Item],
                    completion: @escaping ([Item]) -> Void)
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
                    itemList: [Item],
                    completion: @escaping ([Item]) -> Void) {
        if itemCategory == "whole" {
            completion(itemList)
        } else {
            let filteredItemList = itemList.filter { $0.subType == itemCategory }
            completion(filteredItemList)
        }
    }
}
