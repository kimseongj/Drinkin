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
    let addTriedCocktailListEndpoint = AddTriedCocktailListEndpoint()
    let triedCocktailEndpoint = CocktailsEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - FilterTriedCocktail
    func makeCoktailImageListRepository() -> CocktailImageListRepository {
        return DefaultCocktailImageListRepository(tokenManager: dependencies.tokenManager,
                                                  provider: dependencies.provider,
                                                  endpoint: triedCocktailEndpoint)
    }
    
    func makeFilterTriedCocktailUsecase() -> FilterTriedCocktailUsecase {
        return DefaultFilterTriedCocktailUsecase(cocktailImageListRepository: makeCoktailImageListRepository())
    }
    
    //MARK: - AddTriedCocktail
    func makeAddtionRepository() -> AdditionRepository {
        return DefaultAdditionRepository(tokenManager: dependencies.tokenManager,
                                         provider: dependencies.provider,
                                         endpoint: addTriedCocktailListEndpoint)
    }
    
    func makeAddTriedCocktailUsecase() -> AddTriedCocktailUsecase {
        return DefaultAddTriedCocktailUsecase(additionRepository: makeAddtionRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(filterTriedCocktailUsecase: makeFilterTriedCocktailUsecase(), addTriedCocktailUsecase: makeAddTriedCocktailUsecase())
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        return TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
