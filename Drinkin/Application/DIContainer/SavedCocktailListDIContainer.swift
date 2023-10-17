//
//  SavedCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class SavedCocktailListDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let savedCocktailListEndpoint = SavedCocktailListEndpoint()

    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeSavedCocktailListRepository() -> SavedCocktailListRepository {
        return DefaultSavedCocktailListRepository(tokenManager: dependencies.tokenManager,
                                                  provider: dependencies.provider,
                                                  endpoint: savedCocktailListEndpoint)
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        return DefaultSavedCocktailListViewModel(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewController() -> SavedCocktailListViewController {
        return SavedCocktailListViewController(viewModel: makeSavedCocktailListViewModel())
    }
}
