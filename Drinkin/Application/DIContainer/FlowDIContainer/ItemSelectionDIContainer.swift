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
        DefaultItemSelectionRepository(provider: provider,
                                     endpoint: itemSelectionEndpoint
                                     )
    }
    
    func makeFilterItemUsecase() -> FilterItemUsecase {
        DefaultFilterItemUsecase(itemRepository: makeItemSelectionRepository())
    }
    
    //MARK: - AddItemUsecase
    func makeAdditionRepository() -> AdditionRepository {
        DefaultAdditionRepository(provider: provider, endpoint: addItemEndpoint)
    }
    
    func makeAddItemUsecase() -> AddItemUsecase {
        DefaultAddItemUsecase(additionRepository: makeAdditionRepository())
    }
    
    
    func makeItemSelectionViewModel() -> ItemSelectionViewModel {
        DefaultItemSelectiontViewModel(filterItemUsecase: makeFilterItemUsecase(),
                                        addItemUsecase: makeAddItemUsecase())
    }
    
    func makeItemSelectionViewController() -> ItemSelectionViewController {
        ItemSelectionViewController(viewModel: makeItemSelectionViewModel() )
    }
}
