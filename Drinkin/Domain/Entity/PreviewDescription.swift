//
//  CocktailPreviewDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation

// MARK: - Welcome
struct CocktailPreviewDescription: Codable {
    let cocktailList: [PreviewDescription]

    enum CodingKeys: String, CodingKey {
        case cocktailList = "cocktail_list"
    }
}

// MARK: - CocktailList
struct PreviewDescription: Codable, Hashable {
    let id = UUID()
    let title: String
    let imageURI: String
    let levelGrade, sugarContentGrade, abvGrade, ingredientQuantity: Int

    enum CodingKeys: String, CodingKey {
        case title
        case imageURI = "image_uri"
        case levelGrade = "level_grade"
        case sugarContentGrade = "sugar_content"
        case abvGrade = "abv_level"
        case ingredientQuantity = "ingredient_quantity"
    }
}
