//
//  IngredientFilter.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

//MARK: - IngredientFilter
struct IngredientFilter: Codable, Hashable {
    let ingredientFilterList: [String]
    
    enum CodingKeys: String, CodingKey {
        case ingredientFilterList = "ingredient_filter_list"
    }
}
