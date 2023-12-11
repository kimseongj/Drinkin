//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
    private let provider: Provider
    private let loginManager: LoginManager
    private let holdedItemEndpoint = HoldedItemEndpoint()
    private let deleteHoldedItemEndpoint = DeleteHoldedItemEndpoint()
    
    init(provider: Provider, loginManager: LoginManager) {
        self.provider = provider
        self.loginManager = loginManager 
    }
    
    func makeHoldedItemRepository() -> HoldedItemRepository {
        DefaultHoldedItemRepository(provider: provider,
                                    endpoint: holdedItemEndpoint)
    }
    
    
    func makeDeletionRepository() -> DeletionRepository {
        DefaultDeletionRepository(provider: provider,
                                  endpoint: deleteHoldedItemEndpoint)
    }
    
    func makeDeleteUsecase() -> DeleteItemUsecase {
        DefaultDeleteItemUsecase(deletionRepository: makeDeletionRepository())
    }
    
    func makeMyHomeBarViewModel() -> MyHomeBarViewModel {
        DefaultMyHomeBarViewModel(holdedItemRepository: makeHoldedItemRepository(), deleteItemUsecase: makeDeleteUsecase())
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        MyHomeBarViewController(viewModel: makeMyHomeBarViewModel(),
                                loginManager: loginManager)
    }
}
