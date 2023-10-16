//
//  FetchBaseDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation
import Combine

protocol FetchBaseDescriptionUsecase {
    func execute() -> AnyPublisher<BaseDescription, Error>
}

final class DefaultFetchBaseDescriptionUsecase: FetchBaseDescriptionUsecase {
    private let baseDescriptionRepository: BaseDescriptionRepository
    
    init(baseDescriptionRepository: BaseDescriptionRepository) {
        self.baseDescriptionRepository = baseDescriptionRepository
    }
    
    func execute() -> AnyPublisher<BaseDescription, Error> {
        return baseDescriptionRepository.fetchBaseDescription()
    }
}
