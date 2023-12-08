//
//  HoldedItem.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation

struct HoldedItem: Decodable, Hashable {
    let holdedItemList: [String]
    
    enum CodingKeys: String, CodingKey {
        case holdedItemList = "holded_item_list"
    }
}
