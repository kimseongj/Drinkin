//
//  MyHomeBarViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation
import Combine

protocol MyHomeBarViewModel  {
    var holdedItemListPublisher: Published<[String]>.Publisher { get }

    func fetchHoldedItem()
    func deleteHoldedItem(holdedItem: String)
}

class DefaultMyHomeBarViewModel: MyHomeBarViewModel {
    private let fetchHoldedItemUsecase: FetchHoldedItemUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var holdedItemList: [String] = []
    
    var holdedItemListPublisher: Published<[String]>.Publisher { $holdedItemList }
    
    init(fetchHoldedItemUsecase: FetchHoldedItemUsecase) {
        self.fetchHoldedItemUsecase = fetchHoldedItemUsecase
    }
    
    func fetchHoldedItem() {
        fetchHoldedItemUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.holdedItemList = $0.holdedItemList
        }).store(in: &cancelBag)
    }
    
    func deleteHoldedItem(holdedItem: String) {
        if let index = holdedItemList.firstIndex(of: holdedItem) {
            holdedItemList.remove(at: index)
        }
    }
}
