//
//  FilteredItem.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/06.
//

import Foundation

struct FilteredItem: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let levelGrade: Int
    let sugarContentGrade: Int
    let abvGrade: Int
    let ingredientQuantity: Int
}
