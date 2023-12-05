//
//  SkillDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

struct SkillDetail: Codable {
    let id: Int
    let skillName, description: String

    enum CodingKeys: String, CodingKey {
        case id
        case skillName = "skill_name_ko"
        case description
    }
}
