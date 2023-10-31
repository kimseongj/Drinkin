//
//  MakeableCocktailList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation

//MARK: - MakeableCocktailList
struct MakeableCocktailList: Codable, Hashable {
    let itemFilterList: [String]
    
    enum CodingKeys: String, CodingKey {
        case itemFilterList = "item_filter_list"
    }
}

struct MakeableCocktail:Codable, Hashable {
    let id: Int
    let imageURI: String
    let categoryName: String
    let cocktailName: String
    let levelScore: String
    let abvScore: String
    let sugarContentScore: String
}
