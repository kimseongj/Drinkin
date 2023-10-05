//
//  LoginSettingDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

final class LoginSettingDIContainer {
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
}
