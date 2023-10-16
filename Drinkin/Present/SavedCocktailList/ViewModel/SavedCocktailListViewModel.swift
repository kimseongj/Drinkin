//
//  SavedCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol SavedCocktailListViewModel {
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }

    func fetchCocktailPreviewDescription()
}

class DefaultSavedCocktailListViewModel: SavedCocktailListViewModel {
    private let fetchSavedCocktailListUsecase: FetchSavedCocktailListUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var previewDescriptionList: [CocktailPreview] = []
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    init(fetchSavedCocktailListUsecase: FetchSavedCocktailListUsecase) {
        self.fetchSavedCocktailListUsecase = fetchSavedCocktailListUsecase
    }
    
    func fetchCocktailPreviewDescription() {
        fetchSavedCocktailListUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.previewDescriptionList = $0.cocktailList
        }).store(in: &cancelBag)
    }
}
