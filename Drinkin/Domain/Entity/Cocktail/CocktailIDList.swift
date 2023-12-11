//
//  CocktailIDList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation

struct CocktailIDList: Encodable {
    let cocktailIDList: [Int]
    
    enum CodingKeys: String, CodingKey {
        case cocktailIDList = "cocktail_id_list"
    }
}
