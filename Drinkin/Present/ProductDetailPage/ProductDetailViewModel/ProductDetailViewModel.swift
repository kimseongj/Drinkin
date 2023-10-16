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

class DefaultProductDetailViewModel: ProductDetailViewModel {
    private let fetchCocktailDescriptionUseCase: FetchCocktailDescriptionUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var cocktailDescription: CocktailDescription?
    
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    init(fetchCocktailDescriptionUseCase: FetchCocktailDescriptionUsecase) {
        self.fetchCocktailDescriptionUseCase = fetchCocktailDescriptionUseCase
    }
    
    func fetchDescription() {
        fetchCocktailDescriptionUseCase.execute()
            .sink(receiveCompletion: { print("\($0)")}, receiveValue: {
                self.cocktailDescription = $0
            }).store(in: &cancelBag)
    }
}
