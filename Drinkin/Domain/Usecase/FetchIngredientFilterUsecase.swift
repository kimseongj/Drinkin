//
//  FetchIngredientFilterUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol FetchIngredientFilterUsecase {
    func execute() -> AnyPublisher<ItemFilterList, Error>
}

final class DefaultFetchIngredientFilterUsecase: FetchIngredientFilterUsecase {
    private let ingredientFilterRepository: ItemFilterRepository
    
    init(ingredientFilterRepository: ItemFilterRepository) {
        self.ingredientFilterRepository = ingredientFilterRepository
    }
    
    func execute() -> AnyPublisher<ItemFilterList, Error> {
        return ingredientFilterRepository.fetchIngredientFilter()
    }
}
