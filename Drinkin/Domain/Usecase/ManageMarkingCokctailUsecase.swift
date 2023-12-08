//
//  ManageMarkingCokctailUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/19.
//

import Foundation
import Combine

protocol ManageMarkingCocktailUsecase {
    func markUserMadeCocktail()
    func unmarkUserMadeCocktail()
    func markSavedCocktail()
    func unmarkSavedCocktail()
}

final class DefaultManageMarkingCocktailUsecase: ManageMarkingCocktailUsecase {
    private let cocktailMarkingRepository: CocktailMarkingRepository
    
    init(cocktailMarkingRepository: CocktailMarkingRepository) {
        self.cocktailMarkingRepository = cocktailMarkingRepository
    }
    
    func markUserMadeCocktail() {
        
    }
    
    func unmarkUserMadeCocktail() {
        
    }
    
    func markSavedCocktail() {
        
    }
    
    func unmarkSavedCocktail() {
        
    }
}
