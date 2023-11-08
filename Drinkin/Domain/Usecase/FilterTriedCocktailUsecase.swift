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
    private let cocktailImageListRepository: CocktailImageListRepository
    
    init(cocktailImageListRepository: CocktailImageListRepository) {
        self.cocktailImageListRepository = cocktailImageListRepository
    }

    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, Error> {
        cocktailImageListRepository.fetchCocktailImageList()
    }
    
    func filterCocktail(cocktailCategory: String, cocktailList: [SelectableImageDescription]) {
        
    }
 
}
