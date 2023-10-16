//
//  TriedCocktailSelectionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation
import UIKit

final class TriedCocktailSelectionDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let triedCocktailEndpoint = TriedCocktailEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeTriedCocktailRepository() -> CocktailImageListRepository {
        return DefaultCocktailImageListRepository(tokenManager: dependencies.tokenManager,
                                              provider: dependencies.provider,
                                              endpoint: triedCocktailEndpoint)
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
