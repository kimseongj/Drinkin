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
        DefaultHoldedItemRepository(provider: provider,
                                           endpoint: holdedItemEndpoint)
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        DefaultMyHomeBarViewModel(holdedItemRepository: makeHoldedItemRepository())
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        MyHomeBarViewController(viewModel: makeMyHomeBarViewModel())
    }
}
