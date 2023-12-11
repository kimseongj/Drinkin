//
//  IngredientDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/10.
//

import Combine

protocol IngredientDetailRepository {
    func fetchIngredientDetail() -> AnyPublisher<IngredientDetail, APIError>
}
