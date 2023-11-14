//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
    let provider: Provider
    let cocktailFilterEndpoint = CocktailFilterEndpoint()
    let cocktailListEndpoint = CocktailsEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    //MARK: - CocktailFilter
    func makeCocktailFilterRepository() -> CocktailFilterRepository {
        return DefaultCocktailFilterRepository(provider: provider,
                                               endpoint: cocktailFilterEndpoint)
    }
    
    //MARK: - filterCocktailList
    func makeCocktailListRepository() -> CocktailQueryRepository {
        return DefaultCocktailQueryRepository(provider: provider,
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
