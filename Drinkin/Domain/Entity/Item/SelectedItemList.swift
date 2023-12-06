//
//  PostItemSelectionList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/03.
//

import Foundation

struct SelectedItemList: Encodable {
    let itemList: [SelectedItem]

    enum CodingKeys: String, CodingKey {
        case itemList = "item_list"
    }
}

struct SelectedItem: Encodable, Hashable {
    let type: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
    }
}
