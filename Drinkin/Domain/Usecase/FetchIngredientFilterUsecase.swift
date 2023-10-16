//
//  FetchIngredientFilterUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol FetchIngredientFilterUsecase {
    func execute() -> AnyPublisher<IngredientFilter, Error>
}

final class DefaultFetchIngredientFilterUsecase: FetchIngredientFilterUsecase {
    private let ingredientFilterRepository: IngredientFilterRepository
    
    init(ingredientFilterRepository: IngredientFilterRepository) {
        self.ingredientFilterRepository = ingredientFilterRepository
    }
    
    func execute() -> AnyPublisher<IngredientFilter, Error> {
        return ingredientFilterRepository.fetchIngredientFilter()
    }
}
