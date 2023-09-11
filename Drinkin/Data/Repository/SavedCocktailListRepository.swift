//
//  Saved.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/10.
//

import Foundation
import Combine

protocol SavedCocktailListRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultSavedCocktailListRepository: SavedCocktailListRepository {
    let provider = Provider()
    let endpoint = HoldedItemEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
