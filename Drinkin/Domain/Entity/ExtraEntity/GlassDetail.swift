//
//  GlassDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

// MARK: - GlassDetail
struct GlassDetail: Codable {
    let result: GlassDetailResult
}

// MARK: - GlassDetail
struct GlassDetailResult: Codable {
    let imageURI, glassName, description, capacity: String
    let purchaseLink: String

    enum CodingKeys: String, CodingKey {
        case imageURI = "image_uri"
        case glassName = "glass_name"
        case description, capacity
        case purchaseLink = "purchase_link"
    }
}
