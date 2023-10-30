//
//  ItemDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation

// MARK: - Welcome
struct ItemDetail: Codable {
    let results: ItemDetailResult
}

// MARK: - Results
struct ItemDetailResult: Codable {
    let imageURI: String
    let itemName, purchaseLink, expirationDate: String

    enum CodingKeys: String, CodingKey {
        case imageURI = "image_uri"
        case itemName = "item_name"
        case purchaseLink = "purchase_link"
        case expirationDate = "expiration_date"
    }
}
