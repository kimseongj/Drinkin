//
//  IngredientDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Combine

protocol IngredientDetailRepository {
    func fetchIngredientDetail() -> AnyPublisher<IngredientDetail, Error>
}
