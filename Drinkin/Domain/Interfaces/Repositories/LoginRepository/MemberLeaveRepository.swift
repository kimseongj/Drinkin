//
//  MemberLeaveRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2024/01/05.
//

import Combine

protocol MemberLeaveRepository {
    func postAccessToken() -> AnyPublisher<PostResponse, APIError>
}
