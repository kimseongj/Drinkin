//
//  FilterIngredientUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/22.
//

import Foundation
import Combine

protocol FilterIngredientUsecase {

}

final class DefaultFilterIngredientUsecase: FilterIngredientUsecase {
    private let ingredientFilterRepository: IngredientFilterRepository
    private let ingredientRepository: IngredientRepository
    
    
    @Published var ingredientFilter: [String] = []
    
    init(ingredientFilterRepository: IngredientFilterRepository,
         ingredientRepository: IngredientRepository) {
        self.ingredientFilterRepository = ingredientFilterRepository
        self.ingredientRepository = ingredientRepository
    }
    
    func fetchIngredientFilter() {
        ingredientFilterRepository.fetchIngredientFilter().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.ingredientFilter = $0.ingredientFilterList
        })
    }
    
    func addIngredient(ingredientList: Encodable) -> AnyPublisher<HoldedItem, Error> {
        return ingredientRepository.postIngredientList(receipeItems: ingredientList)
    }
}
