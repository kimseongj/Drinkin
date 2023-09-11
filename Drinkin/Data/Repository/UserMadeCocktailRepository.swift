//
//  UserMadeCocktailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListRepository {
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error>
}

final class DefaultUserMadeCocktailListRepository: UserMadeCocktailListRepository {
    let provider = Provider()
    let endpoint = UserMadeCocktailListEndpoint()
    
    func fetchPublisher() -> AnyPublisher<CocktailPreviewDescription, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
