//
//  PreviewDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

protocol PreviewDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultPreviewDescriptionRepository: PreviewDescriptionRepository {
    let provider = Provider()
    let endpoint = CocktailListEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
