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
    let userMadeCocktailListEndpoint = UserMadeCocktailListEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeUserMadeCocktailListRepository() -> UserMadeCocktailListRepository {
        return DefaultUserMadeCocktailListRepository(tokenManager: dependencies.tokenManager,
                                                     provider: dependencies.provider,
                                                     endpoint: userMadeCocktailListEndpoint)
    }
    
    func makeUserMadeCocktailListViewModel() -> UserMadeCocktailListViewModel {
        return DefaultUserMadeCocktailListViewModel(userMadeCocktailListRepository: makeUserMadeCocktailListRepository())
    }
    
    func makeUserMadeCocktailListViewController() -> UserMadeCocktailListViewController {
        return UserMadeCocktailListViewController(viewModel: makeUserMadeCocktailListViewModel())
    }
}

