//
//  ToolDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

// MARK: - ToolDetail
struct ToolDetail: Codable {
    let result: ToolDetailResult
}

// MARK: - ToolDetailResult
struct ToolDetailResult: Codable {
    let imageURI: String
    let toolName: String
    let description: String
    let purchaseLink: String
    
    enum CodingKeys: String, CodingKey {
        case imageURI = "image_uri"
        case toolName = "tool_name"
        case description
        case purchaseLink = "purchase_link"
    }
}
