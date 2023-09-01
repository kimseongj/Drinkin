//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
    func makeHoldedItemRepository() -> HoldedItemRepository {
        return DefaultHoldedItemRepository()
    }
    
    func makeFetchHoldedItemUsecase() -> FetchHoldedItemUsecase {
        return DefaultFetchHoldedItemUsecase(holdedItemRepository: makeHoldedItemRepository())
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        return DefaultMyHomeBarViewModel(fetchHoldedItemUsecase: makeFetchHoldedItemUsecase())
    }
}
