//
//  CocktailPreviewDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

// MARK: - Welcome
struct CocktailPreviewList: Codable {
    let cocktailList: [CocktailPreview]

    enum CodingKeys: String, CodingKey {
        case cocktailList = "results"
    }
}

// MARK: - CocktailList
struct CocktailPreview: Codable, Hashable {
    let id: Int
    let cocktailNameKo: String
    let imageURI: String
    let levelGrade, sugarContentGrade, abvGrade, ingredientQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case imageURI = "image_uri"
        case levelGrade = "level_score"
        case sugarContentGrade = "sugar_content_score"
        case abvGrade = "abv_score"
        case ingredientQuantity = "ingredient_quantity"
    }
}
