//
//  FilterTriedCocktailUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/08.
//

import Foundation
import Combine

protocol FilterTriedCocktailUsecase {
    
}

class DefaultFilterTriedCocktailUsecase: FilterTriedCocktailUsecase {
    private let triedCocktailRepository: CocktailImageListRepository
    
    init(triedCocktailRepository: CocktailImageListRepository) {
        self.triedCocktailRepository = triedCocktailRepository
    }

    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, Error> {
        triedCocktailRepository.fetchCocktailImageList()
    }
    
    func filterCocktail(cocktailCategory: String, cocktailList: [SelectableImageDescription]) {
        
    }
 
}
