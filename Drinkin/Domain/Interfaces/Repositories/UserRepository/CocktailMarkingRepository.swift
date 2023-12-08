//
//  File.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/08.
//

import Combine

protocol CocktailMarkingRepository {
    func postUserMadeCocktail(cocktail: Encodable) -> AnyPublisher<PostResponse, APIError>
    func postSavedCocktail(cocktail: Encodable) -> AnyPublisher<PostResponse, APIError>
}
