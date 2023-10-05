//
//  UserMadeCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class UserMadeCocktailListDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeUserMadeCocktailListRepository() -> UserMadeCocktailListRepository {
        return DefaultUserMadeCocktailListRepository()
    }
    
    func makeFetchUserMadeCocktailListUsecase() -> FetchUserMadeCocktailListUsecase {
        return DefaultFetchUserMadeCocktailListUsecase(userMadeCocktailListRepository: makeUserMadeCocktailListRepository())
    }
    
    func makeUserMadeCocktailListViewModel() -> UserMadeCocktailListViewModel {
        return DefaultUserMadeCocktailListViewModel(fetchUserMadeCocktailListUsecase: makeFetchUserMadeCocktailListUsecase())
    }
    
    func makeUserMadeCocktailListViewController() -> UserMadeCocktailListViewController {
        return UserMadeCocktailListViewController(viewModel: makeUserMadeCocktailListViewModel())
    }
}

