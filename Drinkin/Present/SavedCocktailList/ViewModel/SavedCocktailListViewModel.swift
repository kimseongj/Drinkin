//
//  SavedCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol SavedCocktailListViewModelInput {
    func fetchCocktailPreviewDescription()
}

protocol SavedCocktailListViewModelOutput {
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }
}

typealias SavedCocktailListViewModel = SavedCocktailListViewModelInput & SavedCocktailListViewModelOutput

final class DefaultSavedCocktailListViewModel: SavedCocktailListViewModel {
    private let savedCocktailListRepository: SavedCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var previewDescriptionList: [CocktailPreview] = []
    
    //MARK: - Init
    init(savedCocktailListRepository: SavedCocktailListRepository) {
        self.savedCocktailListRepository = savedCocktailListRepository
    }
    
    //MARK: - Output
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    //MARK: - Input
    func fetchCocktailPreviewDescription() {
        savedCocktailListRepository.fetchSavedCocktailList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return}
                self.previewDescriptionList = $0.cocktailList
            }).store(in: &cancelBag)
    }
}
