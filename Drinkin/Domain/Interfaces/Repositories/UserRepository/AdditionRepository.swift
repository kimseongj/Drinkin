//
//  AdditionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/11/09.
//

import Foundation
import Combine

protocol AdditionRepository {
    func postTriedCocktail(cocktailIDList: CocktailIDList) -> AnyPublisher<PostResponse, Error>
    func postHoldedItem(items: Encodable) -> AnyPublisher<HoldedItem, Error>
}
