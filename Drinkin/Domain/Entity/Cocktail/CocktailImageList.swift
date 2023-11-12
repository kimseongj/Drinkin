//
//  CocktailImageList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation

struct CocktailImageList: Codable {
    let cocktailImageList: [ImageDescription]

    enum CodingKeys: String, CodingKey {
        case cocktailImageList = "results"
    }
}

struct ImageDescription: Codable, Hashable {
    let id: Int
    let category, cocktailNameKo: String
    let imageURI: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case cocktailNameKo = "cocktail_name_ko"
        case imageURI = "image_uri"
    }
}
