//
//  DefaultMakeableCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation
import Combine

final class DefaultMakeableCocktailListRepository: MakeableCocktailListRepository {
    let provider: Provider
    var baseBrandRelatedCocktailsEndpoint: EndpointMakeable
    var ingredientRelatedCocktailsEndpoint: EndpointMakeable
    let brandID: Int?
    let ingredientID: Int?
    
    init(provider: Provider,
         baseBrandRelatedCocktailsEndpoint: EndpointMakeable,
         ingredientRelatedCocktailsEndpoint: EndpointMakeable,
         brandID: Int?,
         ingredientID: Int?) {
        self.provider = provider
        self.baseBrandRelatedCocktailsEndpoint = baseBrandRelatedCocktailsEndpoint
        self.ingredientRelatedCocktailsEndpoint = ingredientRelatedCocktailsEndpoint
        self.brandID = brandID
        self.ingredientID = ingredientID
    }
    
    func fetchbaseBrandRelatedCocktails() -> AnyPublisher<MakeableCocktailList, APIError> {
        baseBrandRelatedCocktailsEndpoint.insertQuery(queryParameter: "id", queryValue: String(brandID!))
        
        return provider.fetchData(endpoint: baseBrandRelatedCocktailsEndpoint)
    }
    
    func fetchIngredientRelatedCocktails() -> AnyPublisher<MakeableCocktailList, APIError> {
        ingredientRelatedCocktailsEndpoint.insertQuery(queryParameter: "id", queryValue: String(ingredientID!))
        
        return provider.fetchData(endpoint: ingredientRelatedCocktailsEndpoint)
    }
    
    func fetchMakeableCocktails() -> AnyPublisher<MakeableCocktailList, APIError> {
        if brandID == nil {
            return fetchIngredientRelatedCocktails()
        } else {
            return fetchbaseBrandRelatedCocktails()
        }
    }
}
