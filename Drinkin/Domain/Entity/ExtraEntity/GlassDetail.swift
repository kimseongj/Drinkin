//
//  GlassDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

// MARK: - GlassDetail
struct GlassDetail: Codable {
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
