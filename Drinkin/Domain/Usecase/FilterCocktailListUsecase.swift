//
//  FilterCocktailListUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

protocol FilterCocktailListUsecase {
    func initCocktailList() -> AnyPublisher<CocktailPreviewDescription, Error>
    func addFilter(queryParameter: String, queryValue: String) -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultFilterCocktailListUsecase: FilterCocktailListUsecase {
    private let cocktailListRepository: CocktailListRepository
    
    init(cocktailListRepository: CocktailListRepository) {
        self.cocktailListRepository = cocktailListRepository
    }
    
    func initCocktailList() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return cocktailListRepository.fetchPublisher()
    }
    
    func addFilter(queryParameter: String, queryValue: String) -> AnyPublisher<CocktailPreviewDescription, Error> {
        cocktailListRepository.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
        return cocktailListRepository.fetchPublisher()
    }
    
    func clearFilter(queryParameter: String, queryValue: String) {
        
    }
}
