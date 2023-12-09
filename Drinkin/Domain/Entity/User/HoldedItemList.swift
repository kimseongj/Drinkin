//
//  HoldedItem.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItemList: Decodable, Hashable {
    let holdedItemList: [HoldedItem]
    
    enum CodingKeys: String, CodingKey {
        case holdedItemList = "holded_item_list"
    }
}

struct HoldedItem: Decodable, Hashable {
    let itemName: String
    let id: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case itemName = "item_name"
        case id, type
    }
}
