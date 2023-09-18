//
//  CocktailFilterViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/27.
//

import Foundation
import Combine

protocol CocktailFilterViewModel {
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { get }
    var cocktailFilter: CocktailFilter? { get }
    var filterTypeList: [FilterType] { get }
    
    
    func fetchCocktailList()
    func fetchCocktailFilter(completion: @escaping () -> Void)
    func fetchFilterContent(filterType: FilterType) -> [String]
}

final class DefaultCocktailFilterViewModel: CocktailFilterViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var filteredCocktailList: [PreviewDescription] = []
    
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { $filteredCocktailList }
    
    var filterTypeList: [FilterType] = [FilterType.cocktailFilter,
                                FilterType.holdIngredientFilter,
                                FilterType.level,
                                FilterType.abv,
                                FilterType.sugarContent,
                                FilterType.ingredientQuantity]
    
    var cocktailFilter: CocktailFilter? = nil
    
    private let fetchCocktailFilterUsecase: FetchCocktailFilterUsecase
    private let fetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase
    
    init(fetchCocktailFilterUsecase: FetchCocktailFilterUsecase, fetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase) {
        self.fetchCocktailFilterUsecase = fetchCocktailFilterUsecase
        self.fetchPreviewDescriptionUsecase = fetchPreviewDescriptionUsecase
    }
    
    func fetchCocktailList() {
        fetchPreviewDescriptionUsecase.execute().sink(receiveCompletion: {
            print("\($0)")}, receiveValue: {
                self.filteredCocktailList = $0.cocktailList
            }).store(in: &cancelBag)
    }
    
    func fetchCocktailFilter(completion: @escaping () -> Void) {
        fetchCocktailFilterUsecase.execute().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.cocktailFilter = $0
            completion()
        }).store(in: &cancelBag)
    }
    
    func fetchFilterContent(filterType: FilterType) -> [String] {
        guard let cocktailFilter = cocktailFilter else { return [] }
        
        switch filterType {
        case FilterType.cocktailFilter:
            return cocktailFilter.category
        case .holdIngredientFilter:
            return cocktailFilter.holdIngredient
        case .level:
            return cocktailFilter.level
        case .abv:
            return cocktailFilter.abv
        case .sugarContent:
            return cocktailFilter.sugarContent
        case .ingredientQuantity:
            return cocktailFilter.ingredientQuantity
        }
    }
}
