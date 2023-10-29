//
//  SkillDetail.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

// MARK: - SkillDetail
struct SkillDetail: Codable {
    let result: SkillDetailResult
}

// MARK: - SkillDetailResult
struct SkillDetailResult: Codable {
    let skillName, description: String

    enum CodingKeys: String, CodingKey {
        case skillName = "skill_name"
        case description
    }
}
