//
//  FilterCocktailListUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

protocol FilterCocktailListUsecase {
    func fetchCocktailList() -> AnyPublisher<CocktailPreviewDescription, Error>
    func addFilter(queryParameter: String, queryValue: String)
    func clearFilter(queryParameter: String)
    func clearAllFilter()
}

final class DefaultFilterCocktailListUsecase: FilterCocktailListUsecase {
    private let cocktailListRepository: CocktailListRepository
    
    init(cocktailListRepository: CocktailListRepository) {
        self.cocktailListRepository = cocktailListRepository
    }
    
    func fetchCocktailList() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return cocktailListRepository.fetchPublisher()
    }
    
    func addFilter(queryParameter: String, queryValue: String) {
        cocktailListRepository.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
    }
    
    func clearFilter(queryParameter: String) {
        cocktailListRepository.removeQuery(queryParameter: queryParameter)
    }
    
    func clearAllFilter() {
        cocktailListRepository.removeAllQuery()
    }
}
