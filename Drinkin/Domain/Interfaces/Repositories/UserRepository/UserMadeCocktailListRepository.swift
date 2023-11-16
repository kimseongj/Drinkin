//
//  UserMadeCocktailListRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//
import Combine

protocol UserMadeCocktailListRepository {
    func fetchUserMadeCocktailList() -> AnyPublisher<CocktailPreviewList, APIError>
}
