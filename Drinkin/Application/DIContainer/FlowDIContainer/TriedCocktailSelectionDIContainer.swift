//
//  TriedCocktailSelectionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation
import UIKit

final class TriedCocktailSelectionDIContainer {
    let provider: Provider
    private let synchronizationManager: SynchronizationManager
    let addTriedCocktailListEndpoint = AddTriedCocktailListEndpoint()
    let triedCocktailEndpoint = CocktailsEndpoint()
    
    init(provider: Provider,
         synchronizationManager: SynchronizationManager) {
        self.provider = provider
        self.synchronizationManager = synchronizationManager
    }
    
    //MARK: - FilterTriedCocktail
    
    func makeCoktailImageListRepository() -> CocktailImageListRepository {
        DefaultCocktailImageListRepository(provider: provider,
                                           endpoint: triedCocktailEndpoint)
    }
    
    func makeFilterTriedCocktailUsecase() -> FilterTriedCocktailUsecase {
        DefaultFilterTriedCocktailUsecase(cocktailImageListRepository: makeCoktailImageListRepository())
    }
    
    //MARK: - AddTriedCocktail
    
    func makeAddtionRepository() -> AdditionRepository {
        DefaultAdditionRepository(provider: provider,
                                  endpoint: addTriedCocktailListEndpoint)
    }
    
    func makeAddTriedCocktailUsecase() -> AddTriedCocktailUsecase {
        DefaultAddTriedCocktailUsecase(additionRepository: makeAddtionRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        DefaultTriedCocktailSelectionViewModel(filterTriedCocktailUsecase: makeFilterTriedCocktailUsecase(),
                                               addTriedCocktailUsecase: makeAddTriedCocktailUsecase(),
                                               synchronizationManager: synchronizationManager)
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
