//
//  UserMadeCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class UserMadeCocktailListDIContainer {
    func makeUserMadeCocktailListRepository() -> UserMadeCocktailListRepository {
        return DefaultUserMadeCocktailListRepository()
    }
    
    func makeFetchUserMadeCocktailListUsecase() -> FetchUserMadeCocktailListUsecase {
        return DefaultFetchUserMadeCocktailListUsecase(userMadeCocktailListRepository: makeUserMadeCocktailListRepository())
    }
    
    func makeUserMadeCocktailListViewModel() -> UserMadeCocktailListViewModel {
        return DefaultUserMadeCocktailListViewModel(fetchUserMadeCocktailListUsecase: makeFetchUserMadeCocktailListUsecase())
    }
}

