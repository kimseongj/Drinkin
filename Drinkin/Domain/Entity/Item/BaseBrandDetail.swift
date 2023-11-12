//
//  BaseBrandDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

struct BaseBrandDetail: Codable, Hashable {
    let id: Int
    let imageURI: String
    let baseBrandName: String
//    let classification: String
    let abv: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case baseBrandName = "base_brand_name_ko"
//        case classification
        case abv
    }
}
