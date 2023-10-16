//
//  FetchBriefDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol FetchBriefDescriptionUsecase {
    func execute() -> AnyPublisher<CocktailBriefList, Error>
}

class DefaultFetchBriefDescriptionUsecase: FetchBriefDescriptionUsecase {
    private let briefDescriptionRepository: CocktailBriefListRepository
    
    init(briefDescriptionRepository: CocktailBriefListRepository) {
        self.briefDescriptionRepository = briefDescriptionRepository
    }
    
    func execute() -> AnyPublisher<CocktailBriefList, Error> {
        return briefDescriptionRepository.fetchCocktailBriefList()
    }
}
