//
//  TriedCocktailSelectionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation
import UIKit

final class TriedCocktailSelectionDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeTriedCocktailRepository() -> TriedCocktailRepository {
        return DefaultTriedCocktailRepository()
    }
    
    func makeSelectTriedCocktailUsecase() -> SelectTriedCocktailUsecase {
        return DefaultSelectTriedCocktailUsecase(triedCocktailRepository: makeTriedCocktailRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(selectTriedCocktailUsecase: makeSelectTriedCocktailUsecase())
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        return TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
