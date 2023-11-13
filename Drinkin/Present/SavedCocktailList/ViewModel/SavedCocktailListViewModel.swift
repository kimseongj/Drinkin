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

final class DefaultSavedCocktailListViewModel: SavedCocktailListViewModel {
    private let savedCocktailListRepository: SavedCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var previewDescriptionList: [CocktailPreview] = []
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    init(savedCocktailListRepository: SavedCocktailListRepository) {
        self.savedCocktailListRepository = savedCocktailListRepository
    }
    
    func fetchCocktailPreviewDescription() {
        savedCocktailListRepository.fetchSavedCocktailList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return}
                self.previewDescriptionList = $0.cocktailList
            }).store(in: &cancelBag)
    }
}
