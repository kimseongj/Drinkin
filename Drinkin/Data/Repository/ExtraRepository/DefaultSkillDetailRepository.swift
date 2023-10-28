//
//  DefaultSkillDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation

final class DefaultSkillDetailRepository: SkillDetailRepository {
    let skillID: Int
    var endpoint: EndpointMakeable = SkillDetailEndpoint()
    
    init(skillID: Int) {
        self.skillID = skillID
    }
    
    func fetchSkillDetail() {
        //endpoint.insertQuery(queryParameter: "id", queryValue: toolID.description)
    }
}
