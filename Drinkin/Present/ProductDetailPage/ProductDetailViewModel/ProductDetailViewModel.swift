//
//  ProductDetailViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/04.
//

import Foundation
import Combine


protocol ProductDetailViewModel {
    var cocktailDescriptionPublisher: Published< CocktailDescription?>.Publisher { get }
    
    func fetchDescription()
}

final class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let cocktailDetailRepository: CocktailDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var cocktailDescription: CocktailDescription?
    
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    init(cocktailDetailRepository: CocktailDetailRepository) {
        self.cocktailDetailRepository = cocktailDetailRepository
    }
    
    func fetchDescription() {
        cocktailDetailRepository.fetchCocktailDescription()
            .sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
                guard let self = self else { return }
                
                self.cocktailDescription = $0
            }).store(in: &cancelBag)
    }
}
