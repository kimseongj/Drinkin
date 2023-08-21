//
//  TriedCocktailSelectionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/20.
//

import Foundation
import Combine

protocol TriedCocktailSelectionUsecase {
    func execute() -> AnyPublisher<TriedCocktail, Error>
}

class DefaultTriedCocktailSelectionUsecase: TriedCocktailSelectionUsecase {
    private let triedCocktailRepository: TriedCocktailRepository
    
    init(triedCocktailRepository: TriedCocktailRepository) {
        self.triedCocktailRepository = triedCocktailRepository
    }
    
    func execute() -> AnyPublisher<TriedCocktail, Error> {
        return triedCocktailRepository.fetchPublisher()
    }
}
