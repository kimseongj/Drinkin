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
    @Published var cocktailDescription: CocktailDescription?
    
    var cocktailDescriptionPublisher: Published<CocktailDescription?>.Publisher { $cocktailDescription }
    
    private var cancelBag: Set<AnyCancellable> = []
    
    private let fetchDescriptionUseCase: FetchDescriptionUsecase
    
    init(fetchDescriptionUseCase: FetchDescriptionUsecase) {
        self.fetchDescriptionUseCase = fetchDescriptionUseCase
    }
    
    func fetchDescription() {
        fetchDescriptionUseCase.execute()
            .sink(receiveCompletion: { print("\($0)")}, receiveValue: {
                self.cocktailDescription = $0
            }).store(in: &cancelBag)
    }
}
