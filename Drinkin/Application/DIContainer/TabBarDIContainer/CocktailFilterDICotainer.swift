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
        DefaultCocktailFilterRepository(provider: provider,
                                        endpoint: cocktailFilterEndpoint)
    }
    
    //MARK: - filterCocktailList
    
    func makeCocktailListRepository() -> CocktailQueryRepository {
        DefaultCocktailQueryRepository(provider: provider,
                                       endpoint: cocktailListEndpoint)
    }
    
    func makeFilterCocktailListUsecase() -> FilterCocktailListUsecase {
        DefaultFilterCocktailListUsecase(cocktailQueryRepository: makeCocktailListRepository())
    }
    
    
    func makeCocktailFilterViewModel() -> CocktailFilterViewModel {
        DefaultCocktailFilterViewModel(cocktailFilterRepository: makeCocktailFilterRepository(),
                                       filterCocktailListUsecase: makeFilterCocktailListUsecase())
    }
    
    func makeCocktailFilterViewController() -> CocktailFilterViewController {
        CocktailFilterViewController(viewModel: makeCocktailFilterViewModel())
    }
}
