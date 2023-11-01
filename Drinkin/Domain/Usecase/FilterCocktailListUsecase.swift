//
//  FilterCocktailListUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/09.
//

import Foundation
import Combine

protocol FilterCocktailListUsecase {
    func fetchCocktailList() -> AnyPublisher<CocktailPreviewList, Error>
    func addFilter(queryParameter: String, queryValue: String)
    func clearFilter(queryParameter: String)
    func clearAllFilter()
}

final class DefaultFilterCocktailListUsecase: FilterCocktailListUsecase {
    private let cocktailQueryRepository: CocktailQueryRepository
    
    init(cocktailQueryRepository: CocktailQueryRepository) {
        self.cocktailQueryRepository = cocktailQueryRepository
    }
    
    func fetchCocktailList() -> AnyPublisher<CocktailPreviewList, Error> {
        return cocktailQueryRepository.fetchCocktailPreviewList()
    }
    
    func addFilter(queryParameter: String, queryValue: String) {
        cocktailQueryRepository.insertQuery(queryParameter: queryParameter, queryValue: queryValue)
    }
    
    func clearFilter(queryParameter: String) {
        cocktailQueryRepository.removeQuery(queryParameter: queryParameter)
    }
    
    func clearAllFilter() {
        cocktailQueryRepository.removeAllQuery()
    }
}
