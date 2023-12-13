//
//  MyHomeBarDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/01.
//

import Foundation

final class MyHomeBarDIContainer {
    private let provider: Provider
    private let authenticationManager: AuthenticationManager
    private let holdedItemEndpoint = HoldedItemEndpoint()
    private let deleteHoldedItemEndpoint = DeleteHoldedItemEndpoint()
    
    init(provider: Provider, authenticationManager: AuthenticationManager) {
        self.provider = provider
        self.authenticationManager = authenticationManager
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
        DefaultMyHomeBarViewModel(holdedItemRepository: makeHoldedItemRepository(),
                                  deleteItemUsecase: makeDeleteUsecase(),
                                  authenticationManager: authenticationManager)
    }
    
    func makeMyHomeBarViewController() -> MyHomeBarViewController {
        MyHomeBarViewController(viewModel: makeMyHomeBarViewModel())
    }
}
