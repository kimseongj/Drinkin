//
//  BriefDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation

struct CocktailBriefList: Codable {
    let briefDescriptionList: [CocktailBrief]
    
    enum CodingKeys: String, CodingKey {
        case briefDescriptionList = "results"
    }
}

struct CocktailBrief: Codable, Hashable {
    let id: Int
    let cocktailNameKo: String
    let category: String
    let imageURI: String
    let levelScore, abvScore, sugarContentScore: Int
    let description: String
    let ingredientList: [IngredientList]
    let garnishList: [GarnishList]
    let baseList: [BaseList]

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case category
        case imageURI = "image_uri"
        case levelScore = "level_score"
        case abvScore = "abv_score"
        case sugarContentScore = "sugar_content_score"
        case description
        case ingredientList = "ingredient_list"
        case garnishList = "garnish_list"
        case baseList = "base_list"
    }
}

struct BaseList: Codable, Hashable {
    let baseNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case baseNameKo = "base_name_ko"
        case hold
    }
}

struct GarnishList: Codable, Hashable {
    let garnishNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case garnishNameKo = "garnish_name_ko"
        case hold
    }
}

// MARK: - IngredientList
struct IngredientList: Codable, Hashable {
    let ingredientNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case ingredientNameKo = "ingredient_name_ko"
        case hold
    }
}

