//
//  MakeableCocktailListDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/31.
//

import Foundation

final class MakeableCocktailListDIContainer {
    private let provider: Provider
    private let brandID: Int?
    private let ingredientID: Int?
    private let baseBrandRelatedCocktailsEndpoint = BaseBrandRelatedCocktailsEndpoint()
    private let ingredientRelatedCocktailsEndpoint = IngredientRelatedCocktailsEndpoint()
    
    init(provider: Provider, brandID: Int?, ingredientID: Int?) {
        self.provider = provider
        self.brandID = brandID
        self.ingredientID = ingredientID
    }
    
    func makeMakeableCocktailListRepository() -> MakeableCocktailListRepository {
        DefaultMakeableCocktailListRepository(provider: provider,
                                              baseBrandRelatedCocktailsEndpoint: baseBrandRelatedCocktailsEndpoint,
                                              ingredientRelatedCocktailsEndpoint: ingredientRelatedCocktailsEndpoint,
                                              brandID: brandID,
                                              ingredientID: ingredientID)
    }
    
    func makeMakeableCocktailListViewModel() -> MakeableCocktailListViewModel {
        DefaultMakeableCocktailListViewModel(makeableCocktailListRepository: makeMakeableCocktailListRepository())
    }
    
    func makeMakeableCocktailListViewController() -> MakeableCocktailListViewController {
        MakeableCocktailListViewController(viewModel: makeMakeableCocktailListViewModel())
    }
}
