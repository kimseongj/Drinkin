//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeHoldedItemRepository() -> HoldedItemRepository {
        return DefaultHoldedItemRepository()
    }
    
    func makeFetchHoldedItemUsecase() -> FetchHoldedItemUsecase {
        return DefaultFetchHoldedItemUsecase(holdedItemRepository: makeHoldedItemRepository())
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        return DefaultMyHomeBarViewModel(fetchHoldedItemUsecase: makeFetchHoldedItemUsecase())
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        return MyHomeBarViewController(viewModel: makeMyHomeBarViewModel())
    }
}
