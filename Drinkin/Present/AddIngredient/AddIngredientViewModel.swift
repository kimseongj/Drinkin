//
//  AddIngredientViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol AddIngredientViewModel {
    var itemFilterList: [String] { get }
    var itemFilterPublisher: Published<[String]>.Publisher { get }
    var filteredItemListPublisher: Published<[ItemPreview]>.Publisher { get }
    
    func fetchItemFilter()
    func fetchItemList()
    func filterItems(itemCategory: String)
    func addSelectedItems(SelecteditemList: [String], completion: @escaping () -> Void)
    func selectItem(index: Int)
    func deselectItem(index: Int)
}

class DefaultAddIngredientViewModel: AddIngredientViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var itemFilterList: [String] = []
    @Published var itemList: [ItemPreview] = []
    @Published var filteredItemList: [ItemPreview] = []
    var alreadySelectedItemList: [String] = []
    var selectedItemList: [String] = []
    var itemFilterPublisher: Published<[String]>.Publisher { $itemFilterList }
    var filteredItemListPublisher: Published<[ItemPreview]>.Publisher { $filteredItemList }
    
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
            self.filteredItemList = $0.itemList
            self.fetchSelectedItemList(itemList: $0.itemList)
        }).store(in: &cancelBag)
    }
    
    func fetchAlreadySelectedItemList(itemList: [ItemPreview]) {
        alreadySelectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            $0.itemName
        }
    }
    
    func fetchSelectedItemList(itemList: [ItemPreview]) {
        selectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            $0.itemName
        }
    }
    
    func filterItems(itemCategory: String) {
        filterItemUsecase.filterItem(itemCategory: itemCategory, itemList: itemList) {
            self.filteredItemList = $0
        }
    }
    
    func addSelectedItems(SelecteditemList: [String], completion: @escaping () -> Void) {
        let isSelectedItemChanged = compareSelectedItem()
        
        if isSelectedItemChanged {
            print("실행 완료")
//            addItemUsecase.addItem(itemList: itemList).sink(receiveCompletion: { print("\($0)")}, receiveValue: { _ in
//
//            }).store(in: &cancelBag)
        } else { print("변화 없음")
            return }
    }
    
    func compareSelectedItem() -> Bool {
        let alreadySelectedItemSet = Set(alreadySelectedItemList)
        let selectedItemSet = Set(selectedItemList)
        
        return alreadySelectedItemSet == selectedItemSet
    }
    
    func selectItem(index: Int) {
        let selectedItemName = filteredItemList[index].itemName
        
        if let selectedItemIndex = itemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            itemList[selectedItemIndex].hold = true
        }
    }
    
    func deselectItem(index: Int) {
        let selectedItemName = filteredItemList[index].itemName
        
        if let selectedItemIndex = itemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            itemList[selectedItemIndex].hold = false
        }
    }
}
