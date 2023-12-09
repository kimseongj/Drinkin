//
//  HoldedItemRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol HoldedItemRepository {
    func fetchHoldedItem() -> AnyPublisher<HoldedItemList, APIError>
}
