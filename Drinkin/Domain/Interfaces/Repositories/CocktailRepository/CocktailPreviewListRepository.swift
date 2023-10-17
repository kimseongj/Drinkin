//
//  CocktailPreviewListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol CocktailPreviewListRepository {
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error>
}
