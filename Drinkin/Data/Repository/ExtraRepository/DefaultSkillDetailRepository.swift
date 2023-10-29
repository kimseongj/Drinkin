//
//  DefaultSkillDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

final class DefaultSkillDetailRepository: SkillDetailRepository {
    let skillID: Int
    let provider = Provider()
    var endpoint: EndpointMakeable = SkillDetailEndpoint()
    
    init(skillID: Int) {
        self.skillID = skillID
    }
    
    func fetchSkillDetail() -> AnyPublisher<SkillDetail, Error> {
        //endpoint.insertQuery(queryParameter: "id", queryValue: toolID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
