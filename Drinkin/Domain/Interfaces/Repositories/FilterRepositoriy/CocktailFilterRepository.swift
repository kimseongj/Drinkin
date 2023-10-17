//
//  CocktailFilterRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol CocktailFilterRepository {
    func fetchCocktailFilter() -> AnyPublisher<CocktailFilter, Error>
}
