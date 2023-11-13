//
//  MakeableCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/31.
//

import Foundation

final class MakeableCocktailListDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
        let brandID: Int
    }
    
    let dependencies: Dependencies
    let makeableEndpoint = MakeableCocktailListEndpoint()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func makeMakeableCocktailListRepository() -> MakeableCocktailListRepository {
        return DefaultMakeableCocktailListRepository(tokenManager: dependencies.tokenManager,
                                                     provider: dependencies.provider,
                                                     endpoint: makeableEndpoint,
                                                     brandID: dependencies.brandID)
    }

    func makeMakeableCocktailListViewModel() -> MakeableCocktailListViewModel {
        return DefaultMakeableCocktailListViewModel(makeableCocktailListRepository: makeMakeableCocktailListRepository())
    }

    func makeMakeableCocktailListViewController() -> MakeableCocktailListViewController {
        return MakeableCocktailListViewController(viewModel: makeMakeableCocktailListViewModel())
    }
}
