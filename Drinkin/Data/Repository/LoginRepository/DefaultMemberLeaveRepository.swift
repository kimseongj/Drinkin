//
//  DefaultMemberLeaveRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2024/01/05.
//

import Foundation
import Combine

final class DefaultMemberLeaveRepository: MemberLeaveRepository {
    let provider: Provider
    let endpoint: EndpointMakeable
    
    init(provider: Provider, endpoint: EndpointMakeable) {
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func postAccessToken() -> AnyPublisher<PostResponse, APIError> {
        return provider.postData(endpoint: endpoint, bodyItem: "")
    }
}
