//
//  AddIngredientDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import UIKit

final class AddIngredientDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeIngredientFilterRepository() -> IngredientFilterRepository {
        return DefaultIngredientFilterRepository()
    }
    
    func makeFetchIngredientFilterUsecase() -> FetchIngredientFilterUsecase {
        return DefaultFetchIngredientFilterUsecase(ingredientFilterRepository: makeIngredientFilterRepository())
    }
    
    func makeAddIngredientViewModel() -> AddIngredientViewModel {
        return DefaultAddIngredientViewModel(fetchIngredientFilterUsecase: makeFetchIngredientFilterUsecase())
    }
    
    func makeAddIngredientViewController() -> AddIngredientViewController {
        return AddIngredientViewController(viewModel: makeAddIngredientViewModel() )
    }
}
