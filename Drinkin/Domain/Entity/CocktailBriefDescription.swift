//
//  BriefDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation

// MARK: - Welcome
struct CocktailBriefDescription: Codable {
    let briefDescriptionList: [BriefDescription]
    
    enum CodingKeys: String, CodingKey {
        case briefDescriptionList = "results"
    }
}

// MARK: - Result
struct BriefDescription: Codable, Hashable {
    let id: Int
    let cocktailNameKo: String
    let imageURI: String
    let levelScore, abvScore, sugarContentScore: Int
    let description: String
    let ingredientList: [IngredientList]
    let garnishList: [GarnishList]
    let categoryList: [CategoryList]

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case imageURI = "image_uri"
        case levelScore = "level_score"
        case abvScore = "abv_score"
        case sugarContentScore = "sugar_content_score"
        case description
        case ingredientList = "ingredient_list"
        case garnishList = "garnish_list"
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable, Hashable {
    let categoryNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case categoryNameKo = "category_name_ko"
        case hold
    }
}

// MARK: - GarnishList
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
