//
//  PostItemSelectionList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/03.
//

import Foundation

struct PostItemSelectionList: Encodable {
    let itemList: [PostItem]

    enum CodingKeys: String, CodingKey {
        case itemList = "item_list"
    }
}

struct PostItem: Encodable, Hashable {
    let type: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
    }
}
