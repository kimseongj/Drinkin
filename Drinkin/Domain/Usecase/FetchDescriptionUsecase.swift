//
//  FetchDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol FetchDescriptionUsecase {
    func execute() -> AnyPublisher<CocktailDescription, Error>
}

class DefaultFetchDescriptionUsecase: FetchDescriptionUsecase {
    private let descriptionRepository: DescriptionRepository
    
    init(descriptionRepository: DescriptionRepository) {
        self.descriptionRepository = descriptionRepository
    }
    
    func execute() -> AnyPublisher<CocktailDescription, Error> {
        return descriptionRepository.fetchPublisher()
    }
}
