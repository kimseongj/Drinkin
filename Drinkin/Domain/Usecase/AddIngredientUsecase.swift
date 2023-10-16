//
//  AddIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/12.
//

import Foundation
import Combine

protocol AddIngredientUsecase {
    func fetchIngredientList () -> AnyPublisher<IngredientDescription, Error>
}

final class DefaultAddIngredientUsecase: AddIngredientUsecase {
    private let ingredientRepository: IngredientRepository
    
    init(ingredientRepository: IngredientRepository) {
        self.ingredientRepository = ingredientRepository
    }
    
    func addIngredient(ingredientList: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return ingredientRepository.postIngredientList(receipeItems: ingredientList)
    }
}
