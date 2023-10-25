//
//  AddIngredientViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol AddIngredientViewModel {
    var itemFilterPublisher: Published<[String]>.Publisher { get }
    var itemListPublisher: Published<[ItemPreview]>.Publisher { get }
    
    func fetchItemFilter()
    func fetchItemList()
    func filterItem(itemCategory: String)
    func addItem(itemList: [String], completion: @escaping () -> Void)
}

class DefaultAddIngredientViewModel: AddIngredientViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var itemFilterList: [String] = []
    @Published var itemList: [ItemPreview] = []
    var selectedItemList: [String] = []
    var itemFilterPublisher: Published<[String]>.Publisher { $itemFilterList }
    var itemListPublisher: Published<[ItemPreview]>.Publisher { $itemList }
    
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
    
    func fetchItemFilter() {
        ingredientFilterRepository.fetchIngredientFilter().sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            self.itemFilterList = $0.itemFilterList
        }).store(in: &cancelBag)
    }
    
    func fetchItemList() {
        filterItemUsecase.fetchItemList().sink(receiveCompletion: { print("\($0)") }, receiveValue: { [weak self] in
            guard let self = self else { return }
            self.itemList = $0.itemList
            self.fetchSelectedItemList(itemList: $0.itemList)
        }).store(in: &cancelBag)
    }
    
    func filterItem(itemCategory: String) {
        filterItemUsecase.filterItem(itemCategory: itemCategory) {
            self.itemList = $0
        }
    }
    
    func addItem(itemList: [String], completion: @escaping () -> Void) {
        addItemUsecase.addItem(itemList: itemList).sink(receiveCompletion: { print("\($0)")}, receiveValue: { _ in
            
        }).store(in: &cancelBag)
    }
}
