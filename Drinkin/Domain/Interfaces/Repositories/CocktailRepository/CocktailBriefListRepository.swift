//
//  CocktailBriefListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol CocktailBriefListRepository {
    func fetchCocktailBriefList() -> AnyPublisher<CocktailBriefList, APIError>
}
