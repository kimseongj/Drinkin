//
//  SkillDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

protocol SkillDetailRepository {
    func fetchSkillDetail() -> AnyPublisher<SkillDetail, Error>
}
