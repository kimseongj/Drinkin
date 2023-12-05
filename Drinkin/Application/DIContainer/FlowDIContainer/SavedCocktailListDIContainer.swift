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
        DefaultSavedCocktailListRepository(provider: provider,
                                                  endpoint: savedCocktailListEndpoint)
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        DefaultSavedCocktailListViewModel(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewController() -> SavedCocktailListViewController {
        SavedCocktailListViewController(viewModel: makeSavedCocktailListViewModel())
    }
}
