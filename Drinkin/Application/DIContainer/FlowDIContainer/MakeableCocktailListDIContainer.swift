//
//  MakeableCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/31.
//

import Foundation

final class MakeableCocktailListDIContainer {
    let provider: Provider
    let brandID: Int
    let makeableEndpoint = MakeableCocktailListEndpoint()
    
    init(provider: Provider, brandID: Int) {
        self.provider = provider
        self.brandID = brandID
    }
    
    func makeMakeableCocktailListRepository() -> MakeableCocktailListRepository {
        return DefaultMakeableCocktailListRepository(provider: provider,
                                                     endpoint: makeableEndpoint,
                                                     brandID: brandID)
    }
    
    func makeMakeableCocktailListViewModel() -> MakeableCocktailListViewModel {
        return DefaultMakeableCocktailListViewModel(makeableCocktailListRepository: makeMakeableCocktailListRepository())
    }
    
    func makeMakeableCocktailListViewController() -> MakeableCocktailListViewController {
        return MakeableCocktailListViewController(viewModel: makeMakeableCocktailListViewModel())
    }
}
