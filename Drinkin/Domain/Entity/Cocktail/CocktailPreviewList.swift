//
//  CocktailPreviewDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

// MARK: - ScoreList로 바꿀것
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
    let levelScore, sugarContentScore, abvScore, ingredientQuantity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case cocktailNameKo = "cocktail_name_ko"
        case imageURI = "image_uri"
        case levelScore = "level_score"
        case sugarContentScore = "sugar_content_score"
        case abvScore = "abv_score"
        case ingredientQuantity = "ingredient_quantity"
    }
}
