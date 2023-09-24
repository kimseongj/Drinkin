//
//  IngredientDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

// MARK: - CocktailFilter
struct IngredientDescription: Codable, Hashable {
    let title: String
    let ingredientCategory: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case title
        case ingredientCategory = "ingredient_category"
        case hold
    }
}
