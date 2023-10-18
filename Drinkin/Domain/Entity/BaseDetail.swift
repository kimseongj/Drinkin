//
//  BaseDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation

struct BaseDetail: Codable {
    let baseName, baseDescription: String
    let brandList: [BrandImageDescription]

    enum CodingKeys: String, CodingKey {
        case baseName = "base_name"
        case baseDescription = "base_description"
        case brandList = "brand_list"
    }
}

struct BrandImageDescription: Codable, Hashable {
    let id: Int
    let imageURI: String
    let brandName: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case brandName = "brand_name"
    }
}
