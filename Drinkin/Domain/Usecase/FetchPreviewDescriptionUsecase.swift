//
//  FetchPreviewDescriptionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol FetchPreviewDescriptionUsecase {
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultFetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase {
    private let previewDescriptionRepository: PreviewDescriptionRepository
    
    init(previewDescriptionRepository: PreviewDescriptionRepository) {
        self.previewDescriptionRepository = previewDescriptionRepository
    }
    
    func execute() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return previewDescriptionRepository.fetchPublisher()
    }
}
