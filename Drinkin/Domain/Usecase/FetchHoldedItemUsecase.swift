//
//  FetchHoldedItemUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation
import Combine

protocol FetchHoldedItemUsecase {
    func execute() -> AnyPublisher<HoldedItem, Error>
}

final class DefaultFetchHoldedItemUsecase: FetchHoldedItemUsecase {
    private let holdedItemRepository: HoldedItemRepository
    
    init(holdedItemRepository: HoldedItemRepository) {
        self.holdedItemRepository = holdedItemRepository
    }
    
    func execute() -> AnyPublisher<HoldedItem, Error> {
        return holdedItemRepository.fetchPublisher()
    }
}
