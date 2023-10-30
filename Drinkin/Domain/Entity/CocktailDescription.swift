//
//  CocktailDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation
 
//MARK: - CocktailDescription
struct CocktailDescription: Codable {
    let id: Int
    let cocktailNameKo, cocktailNameEng: String
    let imageURI: String
    let description: String
    let recipeList: [String]
    let abv, level, sugarContent: String
    let baseList: [DetailBase]
    let ingredientList: [DetailIngredient]
    let toolList: [CocktailTool]
    let skillList: [CocktailSkill]
    let glassList: [CocktailGlass]

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case cocktailNameEng = "cocktail_name_eng"
        case imageURI = "image_uri"
        case description
        case recipeList = "recipe_list"
        case abv, level
        case sugarContent = "sugar_content"
        case baseList = "base_list"
        case ingredientList = "ingredient_list"
        case toolList = "tool_list"
        case skillList = "skill_list"
        case glassList = "glass"
    }
}

// MARK: - DetailCategory
struct DetailBase: Codable, Hashable {
    let id: Int
    let baseNameKo: String
    let hold: Bool
    let brands: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case baseNameKo = "base_name_ko"
        case hold, brands
    }
}

// MARK: - DetailIngredient
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

// MARK: - CocktailTool
struct CocktailTool: Codable, Hashable {
    let id: Int
    let toolNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case toolNameKo = "tool_name_ko"
    }
}

// MARK: - CocktailSkill
struct CocktailSkill: Codable, Hashable {
    let id: Int
    let skillNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case skillNameKo = "skill_name_ko"
    }
}

// MARK: - CocktailGlass
struct CocktailGlass: Codable, Hashable {
    let id: Int
    let glassNameKo: String

    enum CodingKeys: String, CodingKey {
        case id
        case glassNameKo = "glass_name_ko"
    }
}
