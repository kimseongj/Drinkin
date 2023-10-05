//
//  UserMadeCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class UserMadeCocktailListDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
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

