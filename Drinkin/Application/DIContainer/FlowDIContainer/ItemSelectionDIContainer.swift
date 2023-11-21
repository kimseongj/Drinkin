//
//  AddIngredientDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import UIKit

final class ItemSelectionDIContainer {
    let provider: Provider
    let itemSelectionEndpoint = ItemSelectionEndpoint()
    let addItemEndpoint = AddItemEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    //MARK: - filterItemUsecase
    func makeItemSelectionRepository() -> ItemRepository {
        return DefaultItemSelectionRepository(provider: provider,
                                     endpoint: itemSelectionEndpoint
                                     )
    }
    
    func makeFilterItemUsecase() -> FilterItemUsecase {
        return DefaultFilterItemUsecase(itemRepository: makeItemSelectionRepository())
    }
    
    //MARK: - AddItemUsecase
    func makeAdditionRepository() -> AdditionRepository {
        return DefaultAdditionRepository(provider: provider, endpoint: addItemEndpoint)
    }
    
    func makeAddItemUsecase() -> AddItemUsecase {
        return DefaultAddItemUsecase(additionRepository: makeAdditionRepository())
    }
    
    
    func makeItemSelectionViewModel() -> ItemSelectionViewModel {
        return DefaultItemSelectiontViewModel(filterItemUsecase: makeFilterItemUsecase(),
                                        addItemUsecase: makeAddItemUsecase())
    }
    
    func makeItemSelectionViewController() -> ItemSelectionViewController {
        return ItemSelectionViewController(viewModel: makeItemSelectionViewModel() )
    }
}
