//
//  SavedCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class SavedCocktailListDIContainer {
    let provider: Provider
    let savedCocktailListEndpoint = SavedCocktailListEndpoint()

    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeSavedCocktailListRepository() -> SavedCocktailListRepository {
        return DefaultSavedCocktailListRepository(provider: provider,
                                                  endpoint: savedCocktailListEndpoint)
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        return DefaultSavedCocktailListViewModel(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewController() -> SavedCocktailListViewController {
        return SavedCocktailListViewController(viewModel: makeSavedCocktailListViewModel())
    }
}
