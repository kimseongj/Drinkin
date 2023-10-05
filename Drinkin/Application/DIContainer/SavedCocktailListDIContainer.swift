//
//  SavedCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class SavedCocktailListDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeSavedCocktailListRepository() -> SavedCocktailListRepository {
        return DefaultSavedCocktailListRepository()
    }
    
    func makeFetchSavedCocktailListUsecase() -> FetchSavedCocktailListUsecase {
        return DefaultFetchSavedCocktailListUsecase(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        return DefaultSavedCocktailListViewModel(fetchSavedCocktailListUsecase: makeFetchSavedCocktailListUsecase())
    }
    
    func makeSavedCocktailListViewController() -> SavedCocktailListViewController {
        return SavedCocktailListViewController(viewModel: makeSavedCocktailListViewModel())
    }
}
