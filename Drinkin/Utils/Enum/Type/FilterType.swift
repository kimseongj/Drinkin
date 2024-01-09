//
//  FilterType.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/16.
//

import Foundation

enum FilterType {
    case category
    case level
    case abv
    case sugarContent
    case ingredientQuantity
    
    var queryDescription: String {
        switch self {
        case .category:
            return "category"
        case .level:
            return "level"
        case .abv:
            return "abv"
        case .sugarContent:
            return "sugar_content"
        case .ingredientQuantity:
            return "ingredient_quantity"
        }
    }
    
    var descriptionko: String {
        switch self {
        case .category:
            return "전체 칵테일"
        case .level:
            return "난이도"
        case .abv:
            return "도수"
        case .sugarContent:
            return "당도"
        case .ingredientQuantity:
            return "재료 수"
        }
    }
}
