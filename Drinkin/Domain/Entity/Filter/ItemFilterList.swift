//
//  ItemFilterList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import Foundation

struct ItemFilterList: Codable, Hashable {
    let itemFilterList: [String]
    
    enum CodingKeys: String, CodingKey {
        case itemFilterList = "item_filter_list"
    }
}
