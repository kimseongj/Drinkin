//
//  IngredientInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/30.
//

import Foundation
import Combine

protocol IngredientInformationViewModel {
    func fetchIngredientDetail(completion: @escaping (IngredientDetailResult) -> Void)
}

final class DefaultIngredientInformationViewModel: IngredientInformationViewModel {
    private let ingredientDetailRepository: IngredientDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseBrandDetail: BaseBrandDetail?
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { $baseBrandDetail }
    
    init(ingredientDetailRepository: IngredientDetailRepository) {
        self.ingredientDetailRepository = ingredientDetailRepository
    }
    
    func fetchIngredientDetail(completion: @escaping (IngredientDetailResult) -> Void) {
        ingredientDetailRepository.fetchIngredientDetail().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            completion($0.results)
                }).store(in: &cancelBag)
    }
}
