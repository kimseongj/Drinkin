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
    let cocktailListEndpoint = CocktailListEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - CocktailFilter
    func makeCocktailFilterRepository() -> CocktailFilterRepository {
        return DefaultCocktailFilterRepository(tokenManager: dependencies.tokenManager, provider: dependencies.provider, endpoint: cocktailFilterEndpoint)
    }
    
    func makeFetchCocktailFilterUsecase() -> FetchCocktailFilterUsecase {
        return DefaultFetchCocktailFilterUsecase(cocktailFilterRepository: makeCocktailFilterRepository())
    }
    
    //MARK: - filterCocktailList
    func makeCocktailListRepository() -> CocktailListRepository {
        return DefaultCocktailListRepository(tokenManager: dependencies.tokenManager,
                                             provider: dependencies.provider,
                                             endpoint: cocktailListEndpoint)
    }
    
    func makeFilterCocktailListUsecase() -> FilterCocktailListUsecase {
        return DefaultFilterCocktailListUsecase(cocktailListRepository: makeCocktailListRepository())
    }
    
    
    func makeCocktailFilterViewModel() -> CocktailFilterViewModel {
        return DefaultCocktailFilterViewModel(fetchCocktailFilterUsecase: makeFetchCocktailFilterUsecase(), filterCocktailListUsecase: makeFilterCocktailListUsecase())
    }
    
    func makeCocktailFilterViewController() -> CocktailFilterViewController {
        return CocktailFilterViewController(viewModel: makeCocktailFilterViewModel())
    }
}
