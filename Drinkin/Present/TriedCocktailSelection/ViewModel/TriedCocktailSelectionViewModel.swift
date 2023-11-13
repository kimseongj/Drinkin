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
    func filterCocktailList(cocktailCategoryIndex: Int)
    func selectCocktail(index: Int)
    func deselectCocktail(index: Int)
    func checkCocktailSelected() -> Bool
    func addTriedCocktailList(completion: @escaping () -> Void)
}

protocol TriedCocktailSelectionViewModelOutput {
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { get }
    var categoryList: [String] { get }
}

typealias TriedCocktailSelectionViewModel = TriedCocktailSelectionViewModelInput & TriedCocktailSelectionViewModelOutput

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private let addTriedCocktailUsecase: AddTriedCocktailUsecase
    private let filterTriedCocktailUsecase: FilterTriedCocktailUsecase
    
    init(filterTriedCocktailUsecase: FilterTriedCocktailUsecase,
         addTriedCocktailUsecase: AddTriedCocktailUsecase) {
        self.filterTriedCocktailUsecase = filterTriedCocktailUsecase
        self.addTriedCocktailUsecase = addTriedCocktailUsecase
    }
    
    private var cancelBag: Set<AnyCancellable> = []
    var selectableCocktailList: [SelectableImageDescription] = []
    
    //MARK: - Output
    @Published var filteredSelectableCocktailList: [SelectableImageDescription] = []
    var categoryList: [String] = [CategoryListStrings.whole,
                                  CategoryListStrings.whiskey,
                                  CategoryListStrings.liqueur,
                                  CategoryListStrings.vodka,
                                  CategoryListStrings.gin,
                                  CategoryListStrings.rum,
                                  CategoryListStrings.tequila,
                                  CategoryListStrings.nonAlcoholic,
                                  CategoryListStrings.mixing]
    
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { $filteredSelectableCocktailList }
    
    //MARK: - Input
    func fetchCocktailImageList() {
        filterTriedCocktailUsecase.fetchCocktailImageList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                self.convertSelectableCocktailList(cocktailList: $0.cocktailImageList)
                self.filteredSelectableCocktailList = self.selectableCocktailList
            }).store(in: &cancelBag)
    }
    
    func convertSelectableCocktailList(cocktailList: [ImageDescription]) {
        cocktailList.forEach {
            let convertedImageDescrtipon = SelectableImageDescription(id: $0.id,
                                                                      category: $0.category,
                                                                      cocktailNameKo: $0.cocktailNameKo,
                                                                      imageURI: $0.imageURI)
            selectableCocktailList.append(convertedImageDescrtipon)
        }
    }
    
    func filterCocktailList(cocktailCategoryIndex: Int) {
        let cocktailCategory = categoryList[cocktailCategoryIndex]
        filteredSelectableCocktailList = filterTriedCocktailUsecase.filterCocktail(cocktailCategory: cocktailCategory,
                                                                                   selectableCocktailList: selectableCocktailList)
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
    
    func checkCocktailSelected() -> Bool {
        let result = selectableCocktailList.contains { $0.isSelected == true }
        
        return result
    }
    
    func addTriedCocktailList(completion: @escaping () -> Void) {
        let selectedCocktailList = makeSelectedCocktailIDList()
        
        addTriedCocktailUsecase.addTriedCocktails(cocktailID: selectedCocktailList)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                switch $0 {
                case .finished:
                    print("finished")
                case .failure(_):
                    print("RequestError")
                }
            }, receiveValue: {
                print($0)
                completion()
            }).store(in: &cancelBag)
    }
    
    func makeSelectedCocktailIDList() -> [Int] {
        let selectedCocktailIdList = selectableCocktailList.filter { $0.isSelected == true }.map { $0.id }
        
        return selectedCocktailIdList
    }
}
