//
//  MakeableCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/31.
//

import Foundation
import Combine

protocol MakeableCocktailListRepository {
    func fetchMakeableCocktails() -> AnyPublisher<MakeableCocktailList, Error>
}
