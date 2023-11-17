//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
        let provider: Provider
    let holdedItemEndpoint = HoldedItemEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeHoldedItemRepository() -> HoldedItemRepository {
        return DefaultHoldedItemRepository(provider: provider,
                                           endpoint: holdedItemEndpoint)
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        return DefaultMyHomeBarViewModel(holdedItemRepository: makeHoldedItemRepository())
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        return MyHomeBarViewController(viewModel: makeMyHomeBarViewModel())
    }
}
