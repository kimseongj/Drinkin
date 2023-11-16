//
//  DefaultSkillDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

final class DefaultSkillDetailRepository: SkillDetailRepository {
    let provider = DefaultProvider(tokenManager: DefaultTokenManager())
    var endpoint: EndpointMakeable = SkillDetailEndpoint()
    let skillID: Int
    
    init(skillID: Int) {
        self.skillID = skillID
    }
    
    func fetchSkillDetail() -> AnyPublisher<SkillDetail, APIError> {
        endpoint.insertPathParmeter(pathParameter: skillID.description)
        
        return provider.fetchData(endpoint: endpoint).eraseToAnyPublisher()
    }
}
