//
//  CocktailQueryRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol CocktailQueryRepository {
    func fetchCocktailPreviewList() -> AnyPublisher<CocktailPreviewList, Error>
    func insertQuery(queryParameter: String, queryValue: String)
    func removeQuery(queryParameter: String)
    func removeAllQuery()
}
