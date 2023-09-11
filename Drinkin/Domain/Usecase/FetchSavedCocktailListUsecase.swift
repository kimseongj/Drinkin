//
//  FetchSavedCocktailListUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol FetchSavedCocktailListUsecase {
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultFetchSavedCocktailListUsecase: FetchSavedCocktailListUsecase {
    private let savedCocktailListRepository: SavedCocktailListRepository
    
    init(savedCocktailListRepository: SavedCocktailListRepository) {
        self.savedCocktailListRepository = savedCocktailListRepository
    }
    
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return savedCocktailListRepository.fetchPublisher()
    }
}
