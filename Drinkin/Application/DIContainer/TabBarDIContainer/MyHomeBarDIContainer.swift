//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let holdedItemEndpoint = HoldedItemEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeHoldedItemRepository() -> HoldedItemRepository {
        return DefaultHoldedItemRepository(tokenManager: dependencies.tokenManager,
                                           provider: dependencies.provider,
                                           endpoint: holdedItemEndpoint)
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        return DefaultMyHomeBarViewModel(holdedItemRepository: makeHoldedItemRepository())
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        return MyHomeBarViewController(viewModel: makeMyHomeBarViewModel())
    }
}
