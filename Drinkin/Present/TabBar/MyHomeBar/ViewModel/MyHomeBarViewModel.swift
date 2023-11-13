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
    private let holdedItemRepository: HoldedItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var holdedItemList: [String] = []
    
    var holdedItemListPublisher: Published<[String]>.Publisher { $holdedItemList }
    
    init(holdedItemRepository: HoldedItemRepository) {
        self.holdedItemRepository = holdedItemRepository
    }
    
    func fetchHoldedItem() {
        holdedItemRepository.fetchHoldedItem()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
            guard let self = self else { return }
            self.holdedItemList = $0.holdedItemList
        }).store(in: &cancelBag)
    }
    
    func deleteHoldedItem(holdedItem: String) {
        if let index = holdedItemList.firstIndex(of: holdedItem) {
            holdedItemList.remove(at: index)
        }
    }
}
