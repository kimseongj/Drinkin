//
//  DefaultCocktailPreviewListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/15.
//

import Foundation
import Combine

final class DefaultCocktailPreviewListRepository: CocktailPreviewListRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    let cocktailID: Int
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable, cocktailID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.cocktailID = cocktailID
    }
    
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error> {
        //endpoint.insertQuery(queryParameter: "id", queryValue: cocktailID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
