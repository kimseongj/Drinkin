//
//  CocktailDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation
 
struct CocktailDescription: Codable {
    let id: Int
    let cocktailNameKo, cocktailNameEng: String
    let imageURI: String
    let description: String
    let recipeList: [String]
    let abv, level, sugarContent: String
    let categoryList: [DetailCategory]
    let ingredientList: [DetailIngredient]
    let toolList: [ToolList]
    let skillList: [SkillList]
    let glass: [Glass]

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case cocktailNameEng = "cocktail_name_eng"
        case imageURI = "image_uri"
        case description
        case recipeList = "recipe_list"
        case abv, level
        case sugarContent = "sugar_content"
        case categoryList = "category_list"
        case ingredientList = "ingredient_list"
        case toolList = "tool_list"
        case skillList = "skill_list"
        case glass
    }
}

// MARK: - CategoryList
struct DetailCategory: Codable, Hashable {
    let id: Int
    let categoryNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryNameKo = "category_name_ko"
        case hold
    }
}

// MARK: - IngredientList
struct DetailIngredient: Codable, Hashable {
    let id: Int
    let ingredientNameKo: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case ingredientNameKo = "ingredient_name_ko"
        case hold
    }
}

// MARK: - ToolList
struct ToolList: Codable, Hashable {
    let id: Int
    let toolNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case toolNameKo = "tool_name_ko"
    }
}

// MARK: - SkillList
struct SkillList: Codable, Hashable {
    let id: Int
    let skillNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case skillNameKo = "skill_name_ko"
    }
}

// MARK: - Glass
struct Glass: Codable, Hashable {
    let id: Int
    let glassNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case glassNameKo = "glass_name_ko"
    }
}

