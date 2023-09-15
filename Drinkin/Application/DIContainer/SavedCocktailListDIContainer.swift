//
//  SavedCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class SavedCocktailListDIContainer {
    func makeSavedCocktailListRepository() -> SavedCocktailListRepository {
        return DefaultSavedCocktailListRepository()
    }
    
    func makeFetchSavedCocktailListUsecase() -> FetchSavedCocktailListUsecase {
        return DefaultFetchSavedCocktailListUsecase(savedCocktailListRepository: makeSavedCocktailListRepository())
    }
    
    func makeSavedCocktailListViewModel() -> SavedCocktailListViewModel {
        return DefaultSavedCocktailListViewModel(fetchSavedCocktailListUsecase: makeFetchSavedCocktailListUsecase())
    }
}