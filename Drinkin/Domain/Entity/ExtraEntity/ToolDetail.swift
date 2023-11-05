//
//  ToolDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

// MARK: - ToolDetail
struct ToolDetail: Codable {
    let id: Int
    let imageURI: String
    let toolName: String
    let description: String
    let purchaseLink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURI = "image_uri"
        case toolName = "tool_name_ko"
        case description
        case purchaseLink = "purchase_link"
    }
}
