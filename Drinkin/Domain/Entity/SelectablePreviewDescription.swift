//
//  SelectablePreviewDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/22.
//

import Foundation

//MARK: - SelectablePreviewDescription
struct SelectablePreviewDescription: Hashable {
    let id: Int
    let category, cocktailNameKo, cocktailNameEn: String
    let imageURI: String
    var isSelected: Bool = false
}
