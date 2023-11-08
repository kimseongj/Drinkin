//
//  SelectablePreviewDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/22.
//

import Foundation

struct SelectableImageDescription: Hashable {
    let id: Int
    let category, cocktailNameKo: String
    let imageURI: String
    var isSelected: Bool = false
}
