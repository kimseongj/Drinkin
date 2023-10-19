//
//  TipAndContentList.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

struct TipAndContentList: Codable {
    let tipAndContentList: [TipAndContent]
    
    enum CodingKeys: String, CodingKey {
        case tipAndContentList = "tip_and_content_list"
    }
}

struct TipAndContent: Codable, Hashable {
    let imageURI: String
    let subtitle: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case imageURI = "image_uri"
        case subtitle, title
    }
}

