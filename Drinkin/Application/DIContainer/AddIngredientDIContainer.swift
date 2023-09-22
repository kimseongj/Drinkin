//
//  AddIngredientDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

final class AddIngredientDIContainer {
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
