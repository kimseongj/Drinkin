//
//  File.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/08.
//

import Combine

protocol CocktailMarkingRepository {
    func sendUserMadeCocktail(cocktailID: Int) -> AnyPublisher<PostResponse, APIError>
    func sendBookmarkCocktail(cocktailID: Int) -> AnyPublisher<PostResponse, APIError>
}
