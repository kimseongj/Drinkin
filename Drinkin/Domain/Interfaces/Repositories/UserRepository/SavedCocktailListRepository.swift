//
//  SavedCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol SavedCocktailListRepository {
    func fetchSavedCocktailList() -> AnyPublisher<CocktailPreviewList, Error>
}
