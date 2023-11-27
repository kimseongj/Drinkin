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
    func selectItem(index: Int)
    func deselectItem(index: Int)
    func fetchSelectedItemList()
    func addSelectedItems(completion: @escaping () -> Void)
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
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var itemList: [Item] = []
    @Published var filteredItemList: [Item] = []
    var alreadySelectedItemList: [String] = []
    var selectedItemList: [String] = []
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    @Published var itemFilterList: [ItemFilter] = []
    var itemFilterPublisher: Published<[ItemFilter]>.Publisher { $itemFilterList }
    var filteredItemListPublisher: Published<[Item]>.Publisher { $filteredItemList }
    
    //MARK: - Init
    
    init(filterItemUsecase: FilterItemUsecase,
         addItemUsecase: AddItemUsecase
    ) {
        self.filterItemUsecase = filterItemUsecase
        self.addItemUsecase = addItemUsecase
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
                    self.fetchAlreadySelectedItemList(itemList: $0.itemList)
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    private func fetchAlreadySelectedItemList(itemList: [Item]) {
        alreadySelectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            $0.itemName
        }
    }
}

//MARK: - FilterItem

extension DefaultItemSelectiontViewModel {
    func filterItems(itemCategory: String) {
        filterItemUsecase.filterItem(itemCategory: itemCategory, itemList: itemList) {
            self.filteredItemList = $0
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
    }
    
    func deselectItem(index: Int) {
        let selectedItemName = filteredItemList[index].itemName
        
        if let selectedItemIndex = itemList.firstIndex(where: { $0.itemName == selectedItemName }) {
            itemList[selectedItemIndex].hold = false
        }
    }
}

//MARK: - AddSelectedItem

extension DefaultItemSelectiontViewModel {
    func addSelectedItems(completion: @escaping () -> Void) {
        let isSelectedItemChanged = compareSelectedItem()
        
        if isSelectedItemChanged {
            addItemUsecase.addItems(itemList: selectedItemList)
                .receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")},
                      receiveValue: { _ in
                    completion()
                }).store(in: &cancelBag)
        } else {
            return
        }
    }
    
    func compareSelectedItem() -> Bool {
        let alreadySelectedItemSet = Set(alreadySelectedItemList)
        let selectedItemSet = Set(selectedItemList)
        
        return alreadySelectedItemSet != selectedItemSet
    }
    
    func fetchSelectedItemList() {
        selectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            $0.itemName
        }
    }
}
