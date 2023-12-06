//
//  MakeableCocktailList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation

struct MakeableCocktailList: Decodable, Hashable {
    let makeableCocktailList: [MakeableCocktail]
    
    enum CodingKeys: String, CodingKey {
        case makeableCocktailList = "results"
    }
}

struct MakeableCocktail:Codable, Hashable {
    let id: Int
    let imageURI: String
    let category: String
    let cocktailName: String
    let levelScore: Int
    let abvScore: Int
    let sugarContentScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id, category
        case imageURI = "image_uri"
        case cocktailName = "cocktail_name_ko"
        case levelScore = "level_score"
        case abvScore = "abv_score"
        case sugarContentScore = "sugar_content_score"
    }
}
