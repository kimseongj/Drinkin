//
//  GlassDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

struct GlassDetail: Decodable {
    let id: Int
    let imageURI, glassName, description, volume: String
    let purchaseLink: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case glassName = "glass_name_ko"
        case description, volume
        case purchaseLink = "purchase_link"
    }
}
