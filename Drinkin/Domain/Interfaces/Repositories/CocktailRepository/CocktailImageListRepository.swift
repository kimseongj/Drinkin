//
//  CocktailImageListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol CocktailImageListRepository {
    func fetchCocktailImageList() -> AnyPublisher<CocktailImageDescription, Error>
}
