//
//  ItemSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol ItemSelectionViewModelInput {
    func fetchItemData(completion: @escaping () -> Void)
    func filterItems(itemCategory: String)
    func searchItem(text: String)
    func selectItem(index: Int)
    func deselectItem(index: Int)
    func fetchSelectedItemList()
    func addSelectedItems(completion: @escaping () -> Void)
    func isSelectedItemChange() -> Bool
    func makeDataChangedStatusTrue()
}

protocol ItemSelectionViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var itemFilterList: [ItemFilter] { get }
    var itemFilterPublisher: Published<[ItemFilter]>.Publisher { get }
    var filteredItemListPublisher: Published<[Item]>.Publisher { get }
}

typealias ItemSelectionViewModel = ItemSelectionViewModelInput & ItemSelectionViewModelOutput

final class DefaultItemSelectiontViewModel: ItemSelectionViewModel {
    private let filterItemUsecase: FilterItemUsecase
    private let addItemUsecase: AddItemUsecase
    private let synchronizationManager: SynchronizationManager
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var itemList: [Item] = []
    @Published var filteredItemList: [Item] = []
    var currentFilteredItemList: [Item] = []
    var alreadySelectedItemList: [SelectedItem] = []
    var selectedItemList: [SelectedItem] = []
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    @Published var itemFilterList: [ItemFilter] = []
    var itemFilterPublisher: Published<[ItemFilter]>.Publisher { $itemFilterList }
    var filteredItemListPublisher: Published<[Item]>.Publisher { $filteredItemList }
    
    //MARK: - Init
    
    init(filterItemUsecase: FilterItemUsecase,
         addItemUsecase: AddItemUsecase,
         synchronizationManager: SynchronizationManager
    ) {
        self.filterItemUsecase = filterItemUsecase
        self.addItemUsecase = addItemUsecase
        self.synchronizationManager = synchronizationManager
    }
}

//MARK: - Input
//MARK: - Fetch Data

extension DefaultItemSelectiontViewModel {
    func fetchItemData(completion: @escaping () -> Void) {
        filterItemUsecase.fetchItemData()
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        switch error {
                        case .unauthorized:
                            self.errorType = .unauthorized
                        case .notFound:
                            self.errorType = .notFound
                        case .networkError(_):
                            self.errorType = .networkError(error)
                        case .decodingError:
                            self.errorType = .decodingError
                        case .refreshTokenExpired:
                            self.errorType = .refreshTokenExpired
                        case .noError:
                            break
                        }
                    case .finished:
                        return
                    }
                },
                receiveValue: { [weak self] in
                    guard let self = self else { return }
                    self.itemFilterList = $0.itemFilterList
                    self.itemList = $0.itemList.sorted { $0.itemName < $1.itemName }
                    self.filteredItemList = $0.itemList.sorted { $0.itemName < $1.itemName }
                    self.currentFilteredItemList = self.filteredItemList
                    self.fetchAlreadySelectedItemList(itemList: $0.itemList)
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    private func fetchAlreadySelectedItemList(itemList: [Item]) {
        alreadySelectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            SelectedItem(type: $0.type, id: $0.id)
        }
    }
}

//MARK: - FilterItem

extension DefaultItemSelectiontViewModel {
    func filterItems(itemCategory: String) {
        if itemCategory == "whole" {
            filteredItemList = []
        }
        filteredItemList = filterItemUsecase.filterItem(itemCategory: itemCategory, itemList: itemList)
        currentFilteredItemList = filteredItemList
    }
    
    func searchItem(text: String) {
        filteredItemList = currentFilteredItemList.filter {
            $0.itemName.localizedStandardContains(text)
        }
        
        if text == "" {
            filteredItemList = currentFilteredItemList
        }
    }
}

//MARK: - Select & Deselect Item

extension DefaultItemSelectiontViewModel {
    func selectItem(index: Int) {
        let selectedItemName = filteredItemList[index].itemName
        
        if let selectedItemIndex = itemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            itemList[selectedItemIndex].hold = true
        }
        
        if let selectedItemIndex = currentFilteredItemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            currentFilteredItemList[selectedItemIndex].hold = true
        }
    }
    
    func deselectItem(index: Int) {
        let selectedItemName = filteredItemList[index].itemName
        
        if let selectedItemIndex = itemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            itemList[selectedItemIndex].hold = false
        }
        
        if let selectedItemIndex = currentFilteredItemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            currentFilteredItemList[selectedItemIndex].hold = false
        }
    }
}

//MARK: - AddSelectedItem

extension DefaultItemSelectiontViewModel {
    func addSelectedItems(completion: @escaping () -> Void) {
        addItemUsecase.addItems(itemList: SelectedItemList(itemList: selectedItemList))
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { print("\($0)")},
                receiveValue: { _ in
                    completion()
                }).store(in: &cancelBag)
    }
    
    func isSelectedItemChange() -> Bool {
        let alreadySelectedItemSet = Set(alreadySelectedItemList)
        let selectedItemSet = Set(selectedItemList)
        
        return alreadySelectedItemSet != selectedItemSet
    }
    
    func fetchSelectedItemList() {
        selectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            SelectedItem(type: $0.type, id: $0.id)
        }
    }
}

//MARK: - Synchronizing

extension DefaultItemSelectiontViewModel {
    func makeDataChangedStatusTrue() {
        synchronizationManager.isDataChanged()
    }
}
