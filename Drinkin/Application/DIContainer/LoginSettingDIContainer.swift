//
//  LoginSettingDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

final class LoginSettingDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
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
