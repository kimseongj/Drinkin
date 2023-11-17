//
//  TriedCocktailSelectionUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/20.
//

import Foundation
import Combine

protocol AddTriedCocktailUsecase {
    func addTriedCocktails(cocktailID: [Int]) -> AnyPublisher<PostResponse, APIError>
}

final class DefaultAddTriedCocktailUsecase: AddTriedCocktailUsecase {
    private let additionRepository: AdditionRepository
    
    init(additionRepository: AdditionRepository) {
        self.additionRepository = additionRepository
    }
    
    func addTriedCocktails(cocktailID: [Int]) -> AnyPublisher<PostResponse, APIError> {
        additionRepository.postTriedCocktail(cocktailIDList: CocktailIDList(cocktailIDList: cocktailID))
    }
}
