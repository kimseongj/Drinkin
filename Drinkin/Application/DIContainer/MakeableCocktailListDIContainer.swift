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
        let brandID: Int?
        let ingredientID: Int?
    }
    
    let dependencies: Dependencies
//    let brandBaseEndpoint =
//    let ingredientBaseEndpoint =
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMakeableCocktailListRepository() -> MakeableCocktailListRepository {
        if dependencies.brandID != nil && dependencies.ingredientID == nil {
            
            return DefaultMakeableCocktailListRepository(tokenManager: dependencies.tokenManager,
                                                         provider: dependencies.provider,
                                                         endpoint: //brandBaseEndpoint,
                                                         id: dependencies.brandID!)
        } else if dependencies.brandID == nil && dependencies.ingredientID != nil {
            
            return DefaultMakeableCocktailListRepository(tokenManager: dependencies.tokenManager,
                                                         provider: dependencies.provider,
                                                         endpoint: //brandBaseEndpoint,
                                                         id: dependencies.ingredientID!)
        }
    }
    
    func makeMakeableCocktailListViewModel() -> MakeableCocktailListViewModel {
        return DefaultMakeableCocktailListViewModel(makeableCocktailListRepository: makeMakeableCocktailListRepository())
    }
    
    func makeMakeableCocktailListViewController() -> MakeableCocktailListViewController {
        return MakeableCocktailListViewController(viewModel: makeMakeableCocktailListViewModel())
    }
}
