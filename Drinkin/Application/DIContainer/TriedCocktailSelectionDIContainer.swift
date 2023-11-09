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
    let triedCocktailEndpoint = CocktailsEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCoktailImageListRepository() -> CocktailImageListRepository {
        return DefaultCocktailImageListRepository(tokenManager: dependencies.tokenManager,
                                              provider: dependencies.provider,
                                              endpoint: triedCocktailEndpoint)
    }
    
    //MARK: - FilterTriedCocktailUsecase
    func makeFilterTriedCocktailUsecase() -> FilterTriedCocktailUsecase {
        return DefaultFilterTriedCocktailUsecase(cocktailImageListRepository: makeCoktailImageListRepository())
    }
    
    //MARK: - AddTriedCocktailUsecase
    func makeAddTriedCocktailUsecase() -> AddTriedCocktailUsecase {
        return DefaultAddTriedCocktailUsecase()
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(filterTriedCocktailUsecase: makeFilterTriedCocktailUsecase(), addTriedCocktailUsecase: makeAddTriedCocktailUsecase())
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        return TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
