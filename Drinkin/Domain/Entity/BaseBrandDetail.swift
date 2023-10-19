//
//  BaseBrandDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

struct BaseBrandDetail: Codable {
    let brandDetail: BrandDetail
    
    enum CodingKeys: String, CodingKey {
        case brandDetail = "base_brand"
    }
}

struct BrandDetail: Codable, Hashable {
    let imageURI: String
    let brandName: String
    let classification: String
    let abv: String
    
    enum CodingKeys: String, CodingKey {
        case imageURI = "image_uri"
        case brandName = "brand_name"
        case classification, abv
    }
}
