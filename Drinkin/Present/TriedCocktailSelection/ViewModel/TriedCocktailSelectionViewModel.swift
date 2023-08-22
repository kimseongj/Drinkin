//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine


protocol TriedCocktailSelectionViewModel {
    var cocktailListPublisher: Published<[PreviewDescription]>.Publisher { get }
    var currentCategoryNamePublisher: Published<String>.Publisher { get }
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { get }
    var categoryList: [String] { get }
    var cocktailList: [PreviewDescription] { get }
    var currentCategoryName: String { get set }
    
    func fetchTriedCocktail()
    func filterCocktail()
}

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    private let selectTriedCocktailUsecase: SelectTriedCocktailUsecase
    @Published var cocktailList: [PreviewDescription] = []
    @Published var filteredCocktailList: [PreviewDescription] = []
    @Published var currentCategoryName: String = "전체"
    
    var cocktailListPublisher: Published<[PreviewDescription]>.Publisher { $cocktailList }
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { $filteredCocktailList }
    var currentCategoryNamePublisher: Published<String>.Publisher { $currentCategoryName }
    
    var categoryList: [String] = [CategoryListStrings.whole,
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
            
        }).store(in: &cancelBag)
    }
    
    func filterCocktail() {
        if currentCategoryName == CategoryListStrings.whole {
            filteredCocktailList = cocktailList
        } else {
            filteredCocktailList = cocktailList.filter { $0.category == currentCategoryName }
        }
    }
    
    func checkSelectedItem() {
        cocktailList.forEach {
            let asd = PreviewDescription2(id: $0.id,
                                          category: $0.category,
                                          cocktailNameKo: $0.cocktailNameKo,
                                          cocktailNameEn: $0.cocktailNameEn,
                                          imageURI: $0.imageURI
                                          )
            
            
        }
    }
}
