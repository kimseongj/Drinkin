//
//  TriedCocktail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/18.
//

import Foundation

struct TriedCocktail: Codable {
    let triedCocktailList: [TriedCocktailInformation]
}

struct TriedCocktailInformation: Codable, Hashable {
    let id: Int
    let category: String
    let cocktailNameKo, cocktailNameEn: String
    let imageURI: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case category
        case cocktailNameKo = "cocktail_name_ko"
        case cocktailNameEn = "cocktail_name_en"
        case imageURI = "image_uri"
    }
}
