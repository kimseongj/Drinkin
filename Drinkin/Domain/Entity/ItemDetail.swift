//
//  IngredientDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct ItemList: Codable {
    let itemList: [ItemDetail]
}

struct ItemDetail: Codable, Hashable {
    let itemName: String
    let ingredientCategory: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case ingredientCategory = "ingredient_category"
        case hold
    }
}
