//
//  CocktailImageDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/21.
//

import Foundation

// MARK: - CocktailImageDescription
struct CocktailImageDescription: Codable {
    let previewDescriptionList: [ImageDescription]

    enum CodingKeys: String, CodingKey {
        case previewDescriptionList = "preview_description_list"
    }
}

// MARK: - PreviewDescriptionList
struct ImageDescription: Codable, Hashable {
    let id: Int
    let category, cocktailNameKo, cocktailNameEn: String
    let imageURI: String

    enum CodingKeys: String, CodingKey {
        case id, category
        case cocktailNameKo = "cocktail_name_ko"
        case cocktailNameEn = "cocktail_name_en"
        case imageURI = "image_uri"
    }
}
