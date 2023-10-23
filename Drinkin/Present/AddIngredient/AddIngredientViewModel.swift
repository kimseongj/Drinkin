//
//  AddIngredientViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol AddIngredientViewModel {
    
}

class DefaultAddIngredientViewModel: AddIngredientViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var ingredientFilterList: [String] = []
    @Published var ingredientList: [ItemDetail] = []
    var selectedItemList: [String] = []
    var ingredientFilterPublisher: Published<[String]>.Publisher { $ingredientFilterList }
    var ingredientListPublisher: Published<[ItemDetail]>.Publisher { $ingredientList }
    
    private let ingredientFilterRepository: ItemFilterRepository
    private let filterItemUsecase: FilterItemUsecase
    private let addItemUsecase: AddItemUsecase
    
    init(ingredientFilterRepository: ItemFilterRepository,
         filterItemUsecase: FilterItemUsecase,
         addItemUsecase: AddItemUsecase
    ) {
        self.ingredientFilterRepository = ingredientFilterRepository
        self.filterItemUsecase = filterItemUsecase
        self.addItemUsecase = addItemUsecase
    }
    
    func fetchIngredientFilter() {
        ingredientFilterRepository.fetchIngredientFilter().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.ingredientFilterList = $0.ingredientFilterList
        }).store(in: &cancelBag)
    }
    
    func fetchItemList() {
        
    }
    
    func filterItem(itemCategory: String) {
        filterItemUsecase.filterItem(itemCategory: itemCategory) {
            self.ingredientList = $0
        }
    }
    
    func addItem(itemList: [String]) {
        addItemUsecase.addItem(itemList: itemList).sink(receiveCompletion: { print("\($0)")}, receiveValue: { _ in
            
        }).store(in: &cancelBag)
    }
}
