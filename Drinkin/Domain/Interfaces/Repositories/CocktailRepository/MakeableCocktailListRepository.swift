//
//  MakeableCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/31.
//

import Foundation
import Combine

protocol MakeableCocktailListRepository {
    func fetchMakeableCocktailsByBrand() -> AnyPublisher<MakeableCocktailList, Error>
    func fetchMakeableCocktailsByIngredient() -> AnyPublisher<MakeableCocktailList, Error>
}
