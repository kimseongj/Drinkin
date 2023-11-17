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
        return DefaultCocktailImageListRepository(provider: provider,
                                                  endpoint: triedCocktailEndpoint)
    }
    
    func makeFilterTriedCocktailUsecase() -> FilterTriedCocktailUsecase {
        return DefaultFilterTriedCocktailUsecase(cocktailImageListRepository: makeCoktailImageListRepository())
    }
    
    //MARK: - AddTriedCocktail
    func makeAddtionRepository() -> AdditionRepository {
        return DefaultAdditionRepository(provider: provider,
                                         endpoint: addTriedCocktailListEndpoint)
    }
    
    func makeAddTriedCocktailUsecase() -> AddTriedCocktailUsecase {
        return DefaultAddTriedCocktailUsecase(additionRepository: makeAddtionRepository())
    }
    
    func makeTriedCocktailSelectionViewModel() -> TriedCocktailSelectionViewModel {
        return DefaultTriedCocktailSelectionViewModel(filterTriedCocktailUsecase: makeFilterTriedCocktailUsecase(),
                                                      addTriedCocktailUsecase: makeAddTriedCocktailUsecase())
    }
    
    func makeTriedCocktailSelectionViewController() -> TriedCocktailSelectionViewController {
        return TriedCocktailSelectionViewController(viewModel: makeTriedCocktailSelectionViewModel())
    }
}
