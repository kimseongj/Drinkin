//
//  AddItemsPage.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct AddItemsPage: Codable {
    let itemFilterList: [ItemFilter]
    let itemList: [Item]

    enum CodingKeys: String, CodingKey {
        case itemFilterList = "item_filter_list"
        case itemList = "item_list"
    }
}

struct ItemFilter: Codable, Hashable {
    let name: String
    let type: String
    let subType: String

    enum CodingKeys: String, CodingKey {
        case name, type
        case subType = "sub_type"
    }
}

struct Item: Codable, Hashable {
    let itemName: String
    let type: String
    let subType: String
    let imageURI: String
    var hold: Bool
    let id: Int
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case type
        case subType = "sub_type"
        case imageURI = "image_uri"
        case hold, id, detail
    }
}
