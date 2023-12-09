//
//  DefaultCocktailMarkingRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/06.
//

import Foundation
import Combine

final class DefaultCocktailMarkingRepository: CocktailMarkingRepository {
    let provider: Provider
    var userMadeEndpoint: EndpointMakeable
    var bookmarkEndpoint: EndpointMakeable
    
    init(provider: Provider, userMadeEndpoint: EndpointMakeable, bookmarkEndpoint: EndpointMakeable) {
        self.provider = provider
        self.userMadeEndpoint = userMadeEndpoint
        self.bookmarkEndpoint = bookmarkEndpoint
    }
    
    func sendUserMadeCocktail(cocktailID: Int) -> AnyPublisher<PostResponse, APIError> {
        userMadeEndpoint.insertQuery(queryParameter: "id", queryValue: String(cocktailID))
        
        return provider.fetchData(endpoint: userMadeEndpoint)
    }
    
    func sendBookmarkCocktail(cocktailID: Int) -> AnyPublisher<PostResponse, APIError> {
        bookmarkEndpoint.insertQuery(queryParameter: "id", queryValue: String(cocktailID))
        
        return provider.fetchData(endpoint: bookmarkEndpoint)
    }
}
