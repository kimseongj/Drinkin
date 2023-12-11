//
//  IngredientDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/10.
//

import Foundation

struct IngredientDetail: Decodable {
    let id: Int
    let imageURI: String
    let ingredientName, purchaseLink, expirationDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case ingredientName = "ingredient_name_ko"
        case purchaseLink = "purchase_link"
        case expirationDate = "expiration_date"
    }
}
