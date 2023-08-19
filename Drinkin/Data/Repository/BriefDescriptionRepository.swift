//
//  BriefDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/16.
//

import Foundation
import Combine

protocol BriefDescriptionRepository {
    func fetchPublisher() -> AnyPublisher<CocktailBriefDescription, Error>
}

class DefaultBriefDescriptionRepository: BriefDescriptionRepository {
    let provider = Provider()
    let endpoint = CocktailRecommendEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailBriefDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
