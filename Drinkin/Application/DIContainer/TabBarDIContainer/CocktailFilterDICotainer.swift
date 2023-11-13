//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let cocktailFilterEndpoint = CocktailFilterEndpoint()
    let cocktailListEndpoint = CocktailsEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - CocktailFilter
    func makeCocktailFilterRepository() -> CocktailFilterRepository {
        return DefaultCocktailFilterRepository(tokenManager: dependencies.tokenManager,
                                               provider: dependencies.provider,
                                               endpoint: cocktailFilterEndpoint)
    }
    
    //MARK: - filterCocktailList
    func makeCocktailListRepository() -> CocktailQueryRepository {
        return DefaultCocktailQueryRepository(tokenManager: dependencies.tokenManager,
                                             provider: dependencies.provider,
                                             endpoint: cocktailListEndpoint)
    }
    
    func makeFilterCocktailListUsecase() -> FilterCocktailListUsecase {
        return DefaultFilterCocktailListUsecase(cocktailQueryRepository: makeCocktailListRepository())
    }
    
    
    func makeCocktailFilterViewModel() -> CocktailFilterViewModel {
        return DefaultCocktailFilterViewModel(cocktailFilterRepository: makeCocktailFilterRepository(),
                                              filterCocktailListUsecase: makeFilterCocktailListUsecase())
    }
    
    func makeCocktailFilterViewController() -> CocktailFilterViewController {
        return CocktailFilterViewController(viewModel: makeCocktailFilterViewModel())
    }
}
