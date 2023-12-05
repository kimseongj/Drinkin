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
    let addTriedCocktailListEndpoint = AddTriedCocktailListEndpoint()
    let triedCocktailEndpoint = CocktailsEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
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
                                                      addTriedCocktailUsecase: makeAddTriedCocktailUsecase())
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
