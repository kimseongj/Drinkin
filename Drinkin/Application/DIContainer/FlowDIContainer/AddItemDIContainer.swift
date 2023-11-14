//
//  AddIngredientDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import UIKit

final class AddItemDIContainer {
    let provider: Provider
    let itemFilterEndpoint = ItemFilterEndpoint()
    let itemListEndpoint = ItemListEndpoint()
    let addItemEndpoint = AddItemEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    //MARK: - ItemFilter
    func makeItemFilterRepository() -> ItemFilterRepository {
        return DefaultItemFilterRepository(provider: provider,
                                           endpoint: itemFilterEndpoint)
    }
    
    //MARK: - filterItemUsecase
    func makeItemRepository() -> ItemRepository {
        return DefaultItemRepository(provider: provider,
                                     itemListEndpoint: itemListEndpoint,
                                     addItemEndpoint: addItemEndpoint)
    }
    
    func makeFilterItemUsecase() -> FilterItemUsecase {
        return DefaultFilterItemUsecase(itemRepository: makeItemRepository())
    }
    
    //MARK: - AddItemUsecase
    func makeAddItemUsecase() -> AddItemUsecase {
        return DefaultAddItemUsecase(itemRepository: makeItemRepository())
    }
    
    
    func makeAddItemViewModel() -> AddItemViewModel {
        return DefaultAddItemtViewModel(ingredientFilterRepository: makeItemFilterRepository(),
                                        filterItemUsecase: makeFilterItemUsecase(),
                                        addItemUsecase: makeAddItemUsecase())
    }
    
    func makeAddItemViewController() -> AddItemViewController {
        return AddItemViewController(viewModel: makeAddItemViewModel() )
    }
}
