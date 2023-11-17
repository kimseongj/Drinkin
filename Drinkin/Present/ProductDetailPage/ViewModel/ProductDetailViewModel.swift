//
//  ProductDetailViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/04.
//

import Foundation
import Combine


protocol ProductDetailViewModelInput {
    func fetchDescription()
}

protocol ProductDetailViewModelOutput {
    var cocktailDescriptionPublisher: Published< CocktailDescription?>.Publisher { get }
}

typealias ProductDetailViewModel = ProductDetailViewModelInput & ProductDetailViewModelOutput

final class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let cocktailDetailRepository: CocktailDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var cocktailDescription: CocktailDescription?
    
    //MARK: - Init
    init(cocktailDetailRepository: CocktailDetailRepository) {
        self.cocktailDetailRepository = cocktailDetailRepository
    }
    
    //MARK: - Output
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    //MARK: - Input
    func fetchDescription() {
        cocktailDetailRepository.fetchCocktailDescription()
            .sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
                guard let self = self else { return }
                
                self.cocktailDescription = $0
            }).store(in: &cancelBag)
    }
}
