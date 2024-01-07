//
//  ManagerMemberLeaveUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2024/01/05.
//

import Foundation
import Combine

protocol ManagerMemberLeaveUsecase {
    func withdraw() -> AnyPublisher<PostResponse, APIError>
}

final class DefaultManagerMemberLeaveUsecase: ManagerMemberLeaveUsecase {
    private let memberLeaveRepository: MemberLeaveRepository
    
    init(memberLeaveRepository: MemberLeaveRepository) {
        self.memberLeaveRepository = memberLeaveRepository
    }
    
    func withdraw() -> AnyPublisher<PostResponse, APIError> {
        return memberLeaveRepository.postAccessToken()
    }
}
