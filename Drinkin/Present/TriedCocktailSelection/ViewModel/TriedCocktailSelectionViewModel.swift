//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine

protocol TriedCocktailSelectionViewModelInput {
    func fetchCocktailImageList()
    func filterCocktailList(cocktailCategory: String)
    func selectCocktail(index: Int)
    func deselectCocktail(index: Int)
    func checkCocktailSelected() -> Bool
}

protocol TriedCocktailSelectionViewModelOutput {
    var selectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { get }
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { get }
    var categoryList: [String] { get }
    var currentCategoryName: String { get set }
}

typealias TriedCocktailSelectionViewModel = TriedCocktailSelectionViewModelInput & TriedCocktailSelectionViewModelOutput

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    private let addTriedCocktailUsecase: AddTriedCocktailUsecase
    private let filterTriedCocktailUsecase: FilterTriedCocktailUsecase
    
    var currentCategoryName: String = CategoryListStrings.whole
    @Published var cocktailList: [ImageDescription] = []
    @Published var selectableCocktailList: [SelectableImageDescription] = []
    @Published var filteredSelectableCocktailList: [SelectableImageDescription] = []
    
    var selectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { $selectableCocktailList }
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { $filteredSelectableCocktailList }
    
    var categoryList: [String] = [CategoryListStrings.whole,
                                  CategoryListStrings.whiskey,
                                  CategoryListStrings.liqueur,
                                  CategoryListStrings.vodka,
                                  CategoryListStrings.gin,
                                  CategoryListStrings.rum,
                                  CategoryListStrings.tequila,
                                  CategoryListStrings.nonAlcoholic,
                                  CategoryListStrings.mixing]
    
    init(filterTriedCocktailUsecase: FilterTriedCocktailUsecase,
         addTriedCocktailUsecase: AddTriedCocktailUsecase) {
        self.filterTriedCocktailUsecase = filterTriedCocktailUsecase
        self.addTriedCocktailUsecase = addTriedCocktailUsecase
    }
    
    func fetchCocktailImageList() {
        filterTriedCocktailUsecase.fetchCocktailImageList().sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            self.cocktailList = $0.previewDescriptionList
            self.convertSelectableCocktailList()
            self.filteredSelectableCocktailList = self.selectableCocktailList
        }).store(in: &cancelBag)
    }
    
    func filterCocktailList(cocktailCategory: String) {
        filteredSelectableCocktailList = filterTriedCocktailUsecase.filterCocktail(cocktailCategory: cocktailCategory, selectableCocktailList: selectableCocktailList)
    }
    
    func convertSelectableCocktailList() {
        cocktailList.forEach {
            let convertedImageDescrtipon = SelectableImageDescription(id: $0.id,
                                                                      category: $0.category,
                                                                      cocktailNameKo: $0.cocktailNameKo,
                                                                      imageURI: $0.imageURI
            )
            selectableCocktailList.append(convertedImageDescrtipon)
        }
    }
    
    func selectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        
        filteredSelectableCocktailList[index].isSelected = true
        
        if let selectedCocktailIndex = selectableCocktailList.firstIndex(where: { $0.id == selectedID }) {
            selectableCocktailList[selectedCocktailIndex].isSelected = true
        }
    }
    
    func deselectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        
        filteredSelectableCocktailList[index].isSelected = false
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
    
    func makeSelectedCocktailIDList() -> [Int] {
        let selectedCocktailIdList = selectableCocktailList.filter { $0.isSelected == true }.map { $0.id }
        
        return selectedCocktailIdList
    }
}
