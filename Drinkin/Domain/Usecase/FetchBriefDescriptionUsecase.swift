//
//  FetchBriefDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol FetchBriefDescriptionUsecase {
    func execute() -> AnyPublisher<BriefDescription, Error>
}

class DefaultFetchBriefDescriptionUsecase: FetchBriefDescriptionUsecase {
    private let briefDescriptionRepository = BriefDescriptionRepository()
    
//    init(briefDescriptionRepository: BriefDescriptionRepository) {
//        self.briefDescriptionRepository = briefDescriptionRepository
//    }
    
    func execute() -> AnyPublisher<BriefDescription, Error> {
        return briefDescriptionRepository.fetchPublisher()
    }
}
