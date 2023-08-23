//
//  TriedCocktailSelectionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/20.
//

import Foundation
import Combine

protocol SelectTriedCocktailUsecase {
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error>
}

class DefaultSelectTriedCocktailUsecase: SelectTriedCocktailUsecase {
    private let triedCocktailRepository: TriedCocktailRepository
    
    init(triedCocktailRepository: TriedCocktailRepository) {
        self.triedCocktailRepository = triedCocktailRepository
    }
    
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return triedCocktailRepository.fetchPublisher()
    }
}
