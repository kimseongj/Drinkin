//
//  BaseBrandDescription.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation

struct BaseBrandDescription: Codable {
    let baseBrandDescriptionList: [BrandDescription]
    
    enum CodingKeys: String, CodingKey {
        case baseBrandDescriptionList = "base_brand_description_list"
    }
}

struct BrandDescription: Codable, Hashable {
    let title: String
    let imageURI: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURI = "image_uri"
    }
}
