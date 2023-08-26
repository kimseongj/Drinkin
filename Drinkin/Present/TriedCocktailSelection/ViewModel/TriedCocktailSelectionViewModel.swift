//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine

protocol TriedCocktailSelectionViewModel {
    var selectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { get }
    var filteredSelectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { get }
    var categoryList: [String] { get }
    var currentCategoryName: String { get set }
    
    func fetchCocktailPreviewDescription()
    func filterCocktailList()
    func selectCocktail(index: Int)
    func deselectCocktail(index: Int)
    func checkCocktailSelected() -> Bool
}

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    private let selectTriedCocktailUsecase: SelectTriedCocktailUsecase
    @Published var cocktailList: [PreviewDescription] = []
    var currentCategoryName: String = CategoryListStrings.whole
    @Published var selectableCocktailList: [SelectablePreviewDescription] = []
    @Published var filteredSelectableCocktailList: [SelectablePreviewDescription] = []
    
    var selectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { $selectableCocktailList }
    var filteredSelectableCocktailListPublisher: Published<[SelectablePreviewDescription]>.Publisher { $filteredSelectableCocktailList }
    
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

    func fetchCocktailPreviewDescription() {
        selectTriedCocktailUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.cocktailList = $0.previewDescriptionList
            self.convertSelectableCocktailList()
            self.filterCocktailList()
        }).store(in: &cancelBag)
    }
    
    func filterCocktailList() {
        if currentCategoryName == CategoryListStrings.whole {
            filteredSelectableCocktailList = []
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
    
    func extractSelectedCocktailID() -> [Int] {
        let selectedCocktaiIDList = filteredSelectableCocktailList.filter {
            $0.isSelected == true
        }.map { $0.id }
        
        return selectedCocktaiIDList
    }
    
    func checkCocktailSelected() -> Bool {
        let result = selectableCocktailList.contains { $0.isSelected == true }
        
        return result
    }
}
