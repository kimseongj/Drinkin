//
//  UserMadeCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

final class UserMadeCocktailListDIContainer {
    private let provider: Provider
    private let userMadeCocktailListEndpoint = UserMadeCocktailListEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeUserMadeCocktailListRepository() -> UserMadeCocktailListRepository {
        DefaultUserMadeCocktailListRepository(provider: provider,
                                                     endpoint: userMadeCocktailListEndpoint)
    }
    
    func makeUserMadeCocktailListViewModel() -> UserMadeCocktailListViewModel {
        DefaultUserMadeCocktailListViewModel(userMadeCocktailListRepository: makeUserMadeCocktailListRepository())
    }
    
    func makeUserMadeCocktailListViewController() -> UserMadeCocktailListViewController {
        UserMadeCocktailListViewController(viewModel: makeUserMadeCocktailListViewModel())
    }
}

