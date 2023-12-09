//
//  ManageMarkingCokctailUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/19.
//

import Foundation
import Combine

protocol ManageMarkingCocktailUsecase {
    func updateUserMadeCocktailMark(cocktailID: Int) -> AnyPublisher<PostResponse, APIError>
    func updateBookmarkCocktailMark(cocktailID: Int) -> AnyPublisher<PostResponse, APIError> 
}

final class DefaultManageMarkingCocktailUsecase: ManageMarkingCocktailUsecase {
    private let cocktailMarkingRepository: CocktailMarkingRepository
    
    init(cocktailMarkingRepository: CocktailMarkingRepository) {
        self.cocktailMarkingRepository = cocktailMarkingRepository
    }
    
    func updateUserMadeCocktailMark(cocktailID: Int) -> AnyPublisher<PostResponse, APIError> {
        cocktailMarkingRepository.sendUserMadeCocktail(cocktailID: cocktailID)
    }
    
    func updateBookmarkCocktailMark(cocktailID: Int) -> AnyPublisher<PostResponse, APIError> {
        cocktailMarkingRepository.sendBookmarkCocktail(cocktailID: cocktailID)
    }
}
