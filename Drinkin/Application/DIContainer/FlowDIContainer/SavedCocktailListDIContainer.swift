//
//  SavedCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class SavedCocktailListDIContainer {
    private let provider: Provider
    private let bookmarkCocktailListEndpoint = BookmarkCocktailListEndpoint()

    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeSavedCocktailListRepository() -> SavedCocktailListRepository {
        DefaultSavedCocktailListRepository(provider: provider,
                                                  endpoint: bookmarkCocktailListEndpoint)
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        DefaultSavedCocktailListViewModel(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewController() -> SavedCocktailListViewController {
        SavedCocktailListViewController(viewModel: makeSavedCocktailListViewModel())
    }
}
