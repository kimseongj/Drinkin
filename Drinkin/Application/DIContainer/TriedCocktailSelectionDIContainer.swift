//
//  TriedCocktailSelectionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation

final class TriedCocktailSelectionDIContainer {
    func makeTriedCocktailRepository() -> TriedCocktailRepository {
        return DefaultTriedCocktailRepository()
    }
    
    func makeTriedCocktailSelectionUsecase() -> TriedCocktailSelectionUsecase {
        return DefaultTriedCocktailSelectionUsecase(triedCocktailRepository: makeTriedCocktailRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(triedCocktailSelectionUsecase: makeTriedCocktailSelectionUsecase())
    }
}
