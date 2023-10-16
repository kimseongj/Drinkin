//
//  FetchPreviewDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol FetchPreviewDescriptionUsecase {
    func execute() -> AnyPublisher<CocktailPreviewList, Error>
}

final class DefaultFetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase {
    private let previewDescriptionRepository: CocktailPreviewListRepository
    
    init(previewDescriptionRepository: CocktailPreviewListRepository) {
        self.previewDescriptionRepository = previewDescriptionRepository
    }
    
    func execute() -> AnyPublisher<CocktailPreviewList, Error> {
        return previewDescriptionRepository.fetchPublisher()
    }
}
