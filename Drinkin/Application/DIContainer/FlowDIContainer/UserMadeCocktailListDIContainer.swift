//
//  UserMadeCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class UserMadeCocktailListDIContainer {
    let provider: Provider
    let userMadeCocktailListEndpoint = UserMadeCocktailListEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeUserMadeCocktailListRepository() -> UserMadeCocktailListRepository {
        return DefaultUserMadeCocktailListRepository(provider: provider,
                                                     endpoint: userMadeCocktailListEndpoint)
    }
    
    func makeUserMadeCocktailListViewModel() -> UserMadeCocktailListViewModel {
        return DefaultUserMadeCocktailListViewModel(userMadeCocktailListRepository: makeUserMadeCocktailListRepository())
    }
    
    func makeUserMadeCocktailListViewController() -> UserMadeCocktailListViewController {
        return UserMadeCocktailListViewController(viewModel: makeUserMadeCocktailListViewModel())
    }
}

