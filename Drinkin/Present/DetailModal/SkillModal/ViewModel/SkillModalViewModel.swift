//
//  SkillModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol SkillModalViewModel {
    func fetchSkillDetail(completion: @escaping (SkillDetail) -> Void)
}

final class DefaultSkillModalViewModel: SkillModalViewModel {
    private let skillDetailRepository: SkillDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    init(skillDetailRepository: SkillDetailRepository) {
        self.skillDetailRepository = skillDetailRepository
    }
    
    func fetchSkillDetail(completion: @escaping (SkillDetail) -> Void) {
        skillDetailRepository.fetchSkillDetail().receive(on: RunLoop.main)
            .sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            completion($0)
        }).store(in: &cancelBag)
    }
}
