//
//  ItemList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct ItemList: Codable {
    let itemList: [ItemPreview]
    
    enum CodingKeys: String, CodingKey {
        case itemList = "item_list"
    }
}

struct ItemPreview: Codable, Hashable {
    let itemName: String
    let category: String
    let imageURI: String
    let hold: Bool

    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case category
        case imageURI = "image_uri"
        case hold
    }
}
