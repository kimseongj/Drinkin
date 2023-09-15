//
//  CocktailFilter.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation

// MARK: - CocktailFilter
struct CocktailFilter: Codable {
    let category: [String]
    let holdIngredient: [String]
    let level: [String]
    let abv: [String]
    let sugarContent: [String]
    let ingredientQuantity: [String]

    enum CodingKeys: String, CodingKey {
        case category
        case holdIngredient = "hold_ingredient"
        case level, abv
        case sugarContent = "sugar_content"
        case ingredientQuantity = "ingredient_quantity"
    }
}
