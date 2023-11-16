//
//  FilterTriedCocktailUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/08.
//

import Foundation
import Combine

protocol FilterTriedCocktailUsecase {
    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, APIError>
    func filterCocktail(cocktailCategory: String, selectableCocktailList: [SelectableImageDescription]) -> [SelectableImageDescription]
}

class DefaultFilterTriedCocktailUsecase: FilterTriedCocktailUsecase {
    private let cocktailImageListRepository: CocktailImageListRepository
    
    init(cocktailImageListRepository: CocktailImageListRepository) {
        self.cocktailImageListRepository = cocktailImageListRepository
    }

    func fetchCocktailImageList() -> AnyPublisher<CocktailImageList, APIError> {
        cocktailImageListRepository.fetchCocktailImageList()
    }
    
    func filterCocktail(cocktailCategory: String, selectableCocktailList: [SelectableImageDescription]) -> [SelectableImageDescription] {
        if cocktailCategory == CategoryListStrings.whole {
            return selectableCocktailList
        } else {
            return selectableCocktailList.filter { $0.category == cocktailCategory }
        }
    }
}
