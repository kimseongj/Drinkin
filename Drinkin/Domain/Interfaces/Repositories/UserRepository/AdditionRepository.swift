//
//  AdditionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation
import Combine

protocol AdditionRepository {
    func postTriedCocktail(cocktailIDList: CocktailIDList) -> AnyPublisher<PostResponse, APIError>
    func postHoldedItem(items: Encodable) -> AnyPublisher<PostResponse, APIError>
}
