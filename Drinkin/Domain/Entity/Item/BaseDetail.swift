//
//  BaseDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation

struct BaseDetail: Decodable {
    let baseName, baseDescription: String
    let brandList: [BrandImageDescription]

    enum CodingKeys: String, CodingKey {
        case baseName = "base_name_ko"
        case baseDescription = "description"
        case brandList = "base_brands"
    }
}

struct BrandImageDescription: Codable, Hashable {
    let id: Int
    let imageURI: String
    let brandName: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case brandName = "base_brand_name_ko"
    }
}
