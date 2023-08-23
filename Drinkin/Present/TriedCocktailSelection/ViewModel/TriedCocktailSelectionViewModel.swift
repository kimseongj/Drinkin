//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine


protocol TriedCocktailSelectionViewModel {
    var currentCategoryNamePublisher: Published<String>.Publisher { get }
    var selectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { get }
    var filteredSelectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { get }
    var categoryList: [String] { get }
    var currentCategoryName: String { get set }
    var selectableCocktailList: [SelectablePreviewDescription] { get set } //
    var filteredSelectableCocktailList: [SelectablePreviewDescription] { get set } //
    
    func fetchTriedCocktail()
    func filterCocktail()
    func selectCocktail(index: Int)
    func deselectCocktail(index: Int)
}

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    private let selectTriedCocktailUsecase: SelectTriedCocktailUsecase
    @Published var cocktailList: [PreviewDescription] = []
    @Published var currentCategoryName: String = "전체"
    @Published var selectableCocktailList: [SelectablePreviewDescription] = []
    @Published var filteredSelectableCocktailList: [SelectablePreviewDescription] = []
    
    var selectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { $selectableCocktailList }
    var filteredSelectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { $filteredSelectableCocktailList }
    
    var currentCategoryNamePublisher: Published<String>.Publisher { $currentCategoryName }
    
    var categoryList: [String] = [CategoryListStrings.whole,
                                  CategoryListStrings.whiskey,
                                  CategoryListStrings.liqueur,
                                  CategoryListStrings.vodka,
                                  CategoryListStrings.gin,
                                  CategoryListStrings.rum,
                                  CategoryListStrings.tequila,
                                  CategoryListStrings.nonAlcoholic,
                                  CategoryListStrings.mixing]
    
    
    init(selectTriedCocktailUsecase: SelectTriedCocktailUsecase) {
        self.selectTriedCocktailUsecase = selectTriedCocktailUsecase
    }

    func fetchTriedCocktail() {
        selectTriedCocktailUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.cocktailList = $0.previewDescriptionList
            self.convertSelectableCocktailList()
        }).store(in: &cancelBag)
    }
    
    
    
    
    func filterCocktail() {
        if currentCategoryName == CategoryListStrings.whole {
            filteredSelectableCocktailList = selectableCocktailList
        } else {
            filteredSelectableCocktailList = selectableCocktailList.filter { $0.category == currentCategoryName }
        }
    }
    
    
    
    
    func convertSelectableCocktailList() {
        cocktailList.forEach {
            let convertedPreviewDescription = SelectablePreviewDescription(id: $0.id,
                                          category: $0.category,
                                          cocktailNameKo: $0.cocktailNameKo,
                                          cocktailNameEn: $0.cocktailNameEn,
                                          imageURI: $0.imageURI
                                          )
            selectableCocktailList.append(convertedPreviewDescription)
        }
    }
    
    
    
    
    
    func selectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        
        if let selectedCocktailIndex = selectableCocktailList.firstIndex(where: { $0.id == selectedID }) {
            selectableCocktailList[selectedCocktailIndex].isSelected = true
        }
    }
    
    func deselectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        
        if let selectedCocktailIndex = selectableCocktailList.firstIndex(where: { $0.id == selectedID }) {
            selectableCocktailList[selectedCocktailIndex].isSelected = false
        }
    }
    
    func checkSelectableCocktailList() {
        $selectableCocktailList.sink {
            $0
        }
    }
}
