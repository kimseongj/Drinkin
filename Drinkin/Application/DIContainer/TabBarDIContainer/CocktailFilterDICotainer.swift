//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
    private let provider: Provider
    private let authenticationManager: AuthenticationManager
    private let cocktailFilterEndpoint = CocktailFilterEndpoint()
    private let cocktailListEndpoint = CocktailsEndpoint()
    
    init(provider: Provider, authenticationManager: AuthenticationManager) {
        self.provider = provider
        self.authenticationManager = authenticationManager
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
                                       filterCocktailListUsecase: makeFilterCocktailListUsecase(),
                                       authenticationManager: authenticationManager)
    }
    
    func makeCocktailFilterViewController() -> CocktailFilterViewController {
        CocktailFilterViewController(viewModel: makeCocktailFilterViewModel())
    }
}
