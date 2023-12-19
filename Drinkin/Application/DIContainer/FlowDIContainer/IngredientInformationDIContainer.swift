//
//  IngredientInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/10.
//

import Foundation

final class IngredientInformationDIContainer {
    let provider: Provider
    let ingredientID: Int
    let ingredientInformationEndpoint = IngredientInformationEndpoint()
    
    init(provider: Provider,
         ingredientID: Int) {
        self.provider = provider
        self.ingredientID = ingredientID
    }
    
    func makeIngredientDetailRepository() -> IngredientDetailRepository {
        return DefaultIngredientDetailRepository(provider: provider,
                                                 endpoint: ingredientInformationEndpoint,
                                                 ingredientID: ingredientID)
    }
    
    func makeIngredientInformationViewModel() -> IngredientInformationViewModel {
        return DefaultIngredientInformationViewModel(ingredientDetailRepository: makeIngredientDetailRepository())
    }
    
    func makeIngredientInformationViewController() -> IngredientInformationViewController {
        return IngredientInformationViewController(viewModel: makeIngredientInformationViewModel())
    }
}
