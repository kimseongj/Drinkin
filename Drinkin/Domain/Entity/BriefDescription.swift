//
//  BriefDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation

struct BriefDescription: Decodable {
    let cocktail: [Cocktail]
}

struct Cocktail: Decodable {
    let title: String
    let levelGrade: Int
    let abvGrade: Int
    let sugarContentGrade: Int
    let description: String
    let imageURL: String
}
