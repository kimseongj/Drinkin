//
//  AddIngredientViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol AddItemViewModelInput {
    func fetchItemFilter()
    func fetchItemList()
    func filterItems(itemCategory: String)
    func selectItem(index: Int)
    func deselectItem(index: Int)
    func fetchSelectedItemList()
    func addSelectedItems(completion: @escaping () -> Void)
}

protocol AddItemViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var itemFilterList: [String] { get }
    var itemFilterPublisher: Published<[String]>.Publisher { get }
    var filteredItemListPublisher: Published<[ItemPreview]>.Publisher { get }
}

typealias AddItemViewModel = AddItemViewModelInput & AddItemViewModelOutput

final class DefaultAddItemtViewModel: AddItemViewModel {
    private let ingredientFilterRepository: ItemFilterRepository
    private let filterItemUsecase: FilterItemUsecase
    private let addItemUsecase: AddItemUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var itemList: [ItemPreview] = []
    @Published var filteredItemList: [ItemPreview] = []
    var alreadySelectedItemList: [String] = []
    var selectedItemList: [String] = []
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    @Published var itemFilterList: [String] = []
    var itemFilterPublisher: Published<[String]>.Publisher { $itemFilterList }
    var filteredItemListPublisher: Published<[ItemPreview]>.Publisher { $filteredItemList }
    
    //MARK: - Init
    init(ingredientFilterRepository: ItemFilterRepository,
         filterItemUsecase: FilterItemUsecase,
         addItemUsecase: AddItemUsecase
    ) {
        self.ingredientFilterRepository = ingredientFilterRepository
        self.filterItemUsecase = filterItemUsecase
        self.addItemUsecase = addItemUsecase
    }
}

//MARK: - Input
//MARK: - Fetch Data
extension DefaultAddItemtViewModel {
    
    func fetchItemFilter() {
        ingredientFilterRepository.fetchIngredientFilter()
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
                }
            ).store(in: &cancelBag)
    }
    
    func fetchItemList() {
        filterItemUsecase.fetchItemList()
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
                    self.itemList = $0.itemList
                    self.filteredItemList = $0.itemList
                    self.fetchAlreadySelectedItemList(itemList: $0.itemList)
                }
            ).store(in: &cancelBag)
    }
    
    private func fetchAlreadySelectedItemList(itemList: [ItemPreview]) {
        alreadySelectedItemList = itemList.filter {
            $0.hold == true
        }.map {
            $0.itemName
        }
    }
}

//MARK: - FilterItem
extension DefaultAddItemtViewModel {
    func filterItems(itemCategory: String) {
        filterItemUsecase.filterItem(itemCategory: itemCategory, itemList: itemList) {
            self.filteredItemList = $0
        }
    }
}

//MARK: - Select & Deselect Item
extension DefaultAddItemtViewModel {
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
extension DefaultAddItemtViewModel {
    func addSelectedItems(completion: @escaping () -> Void) {
        let isSelectedItemChanged = compareSelectedItem()
        
        if isSelectedItemChanged {
            addItemUsecase.addItems(itemList: selectedItemList)
                .sink(receiveCompletion: { print("\($0)")},
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
