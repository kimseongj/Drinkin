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
    
    func makeSelectTriedCocktailUsecase() -> SelectTriedCocktailUsecase {
        return DefaultSelectTriedCocktailUsecase(triedCocktailRepository: makeTriedCocktailRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(selectTriedCocktailUsecase: makeSelectTriedCocktailUsecase())
    }
}
