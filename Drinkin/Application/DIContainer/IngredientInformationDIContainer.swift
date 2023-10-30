//
//  IngredientInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation

final class IngredientInformationDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
        let ingredientID: Int
    }
    
    let dependencies: Dependencies
    let ingredientInformationEndpoint = IngredientDetailEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeIngredientDetailRepository() -> IngredientDetailRepository {
        return DefaultIngredientDetailRepository(tokenManager: dependencies.tokenManager,
                                                 provider: dependencies.provider,
                                                 endpoint: ingredientInformationEndpoint,
                                                 ingredientID: dependencies.ingredientID)
    }
    
    func makeIngredientInformationViewModel() -> IngredientInformationViewModel {
        return DefaultIngredientInformationViewModel(ingredientDetailRepository: makeIngredientDetailRepository())
    }
    
    func makeIngredientInformationViewController() -> IngredientInformationViewController {
        return IngredientInformationViewController(viewModel: makeIngredientInformationViewModel())
    }
}
