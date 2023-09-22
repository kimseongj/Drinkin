//
//  AddIngredientViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation
import Combine

protocol AddIngredientViewModel {
    
}

class DefaultAddIngredientViewModel: AddIngredientViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var ingredientFilter: [String] = []
    @Published var ingredientList: [IngredientDescription] = []
    
    var ingredientFilterPublisher: Published<[String]>.Publisher { $ingredientFilter }
    var ingredientListPublisher: Published<[IngredientDescription]>.Publisher { $ingredientList }
    
    private let fetchIngredientFilterUsecase: FetchIngredientFilterUsecase
    
    init(fetchIngredientFilterUsecase: FetchIngredientFilterUsecase) {
        self.fetchIngredientFilterUsecase = fetchIngredientFilterUsecase
    }
    
    
}
