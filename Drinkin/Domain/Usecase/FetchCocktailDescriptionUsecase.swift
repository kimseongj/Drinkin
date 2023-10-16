//
//  FetchDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol FetchCocktailDescriptionUsecase {
    func execute() -> AnyPublisher<CocktailDescription, Error>
}

class DefaultFetchCocktailDescriptionUsecase: FetchCocktailDescriptionUsecase {
    private let cocktailDescriptionRepository: CocktailDetailRepository
    
    init(cocktailDescriptionRepository: CocktailDetailRepository) {
        self.cocktailDescriptionRepository = cocktailDescriptionRepository
    }
    
    func execute() -> AnyPublisher<CocktailDescription, Error> {
        return cocktailDescriptionRepository.fetchCocktailDescription()
    }
}
