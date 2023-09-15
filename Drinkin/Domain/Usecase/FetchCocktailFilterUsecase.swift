//
//  FetchCocktailFilterUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol FetchCocktailFilterUsecase {
    func execute() -> AnyPublisher<CocktailFilter, Error>
}

final class DefaultFetchCocktailFilterUsecase: FetchCocktailFilterUsecase {
    private let cocktailFilterRepository: CocktailFilterRepository
    
    init(cocktailFilterRepository: CocktailFilterRepository) {
        self.cocktailFilterRepository = cocktailFilterRepository
    }
    
    func execute() -> AnyPublisher<CocktailFilter, Error> {
        return cocktailFilterRepository.fetchPublisher()
    }
}
