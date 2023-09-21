//
//  FilterType.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/16.
//

import Foundation

enum FilterType {
    case categoryFilter
    case holdIngredientFilter
    case level
    case abv
    case sugarContent
    case ingredientQuantity
    
    var description: String {
        switch self {
        case .categoryFilter:
            return "전체 칵테일"
        case .holdIngredientFilter:
            return "보유 재료"
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
