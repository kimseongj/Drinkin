//
//  FetchUserMadeCocktailListUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol FetchUserMadeCocktailListUsecase {
    func execute() -> AnyPublisher<CocktailPreviewList, Error>
}

final class DefaultFetchUserMadeCocktailListUsecase: FetchUserMadeCocktailListUsecase {
    private let userMadeCocktailListRepository: UserMadeCocktailListRepository
    
    init(userMadeCocktailListRepository: UserMadeCocktailListRepository) {
        self.userMadeCocktailListRepository = userMadeCocktailListRepository
    }
    
    func execute() -> AnyPublisher<CocktailPreviewList, Error> {
        return userMadeCocktailListRepository.fetchUserMadeCocktailList()
    }
}
