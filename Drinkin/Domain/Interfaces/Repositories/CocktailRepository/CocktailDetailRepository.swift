//
//  CocktailDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol CocktailDetailRepository {
    func fetchCocktailDescription() -> AnyPublisher<CocktailDescription, Error>
}
