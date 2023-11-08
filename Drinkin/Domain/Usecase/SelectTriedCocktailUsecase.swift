//
//  TriedCocktailSelectionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/20.
//

import Foundation
import Combine

protocol SelectTriedCocktailUsecase {
    func execute() -> AnyPublisher<CocktailImageList, Error>
}

class DefaultSelectTriedCocktailUsecase: SelectTriedCocktailUsecase {
    private let triedCocktailRepository: CocktailImageListRepository
    
    init(triedCocktailRepository: CocktailImageListRepository) {
        self.triedCocktailRepository = triedCocktailRepository
    }
    
    func execute() -> AnyPublisher<CocktailImageList, Error> {
        return triedCocktailRepository.fetchCocktailImageList()
    }
}
