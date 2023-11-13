//
//  AddIngredientDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import UIKit

final class AddIngredientDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let itemFilterEndpoint = ItemFilterEndpoint()
    let itemListEndpoint = ItemListEndpoint()
    let addItemEndpoint = AddItemEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    //MARK: - ItemFilter
    func makeItemFilterRepository() -> ItemFilterRepository {
        return DefaultItemFilterRepository(tokenManager: dependencies.tokenManager, provider: dependencies.provider, endpoint: itemFilterEndpoint)
    }
    
    //MARK: - filterItemUsecase
    func makeItemRepository() -> ItemRepository {
        return DefaultItemRepository(tokenManager: dependencies.tokenManager, provider: dependencies.provider, ingredientListEndpoint: itemListEndpoint, addIngredientEndpoint: addItemEndpoint)
    }
    
    func makeFilterItemUsecase() -> FilterItemUsecase {
        return DefaultFilterItemUsecase(itemRepository: makeItemRepository())
    }
    
    //MARK: - AddItemUsecase
    func makeAddItemUsecase() -> AddItemUsecase {
        return DefaultAddItemUsecase(itemRepository: makeItemRepository())
    }
    
    
    func makeAddIngredientViewModel() -> AddIngredientViewModel {
        return DefaultAddIngredientViewModel(ingredientFilterRepository: makeItemFilterRepository(), filterItemUsecase: makeFilterItemUsecase(), addItemUsecase: makeAddItemUsecase())
    }
    
    func makeAddIngredientViewController() -> AddItemViewController {
        return AddItemViewController(viewModel: makeAddIngredientViewModel() )
    }
}
