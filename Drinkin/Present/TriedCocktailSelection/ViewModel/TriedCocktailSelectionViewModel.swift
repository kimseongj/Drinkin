//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine


protocol TriedCocktailSelectionViewModel {
    var cocktailListPublisher: Published< [TriedCocktailInformation]>.Publisher { get }
    var categoryList: [String] { get }
    
    func fetchTriedCocktail()
    func filterCocktail(cocktailList: [TriedCocktailInformation], categoryName: String) -> [TriedCocktailInformation]
}

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    @Published var cocktailList: [TriedCocktailInformation] = []
    
    var cocktailListPublisher: Published<[TriedCocktailInformation]>.Publisher { $cocktailList }
    
    var categoryList: [String] = [CategoryListStrings.whole,
                                  CategoryListStrings.liqueur,
                                  CategoryListStrings.vodka,
                                  CategoryListStrings.gin,
                                  CategoryListStrings.rum,
                                  CategoryListStrings.tequila,
                                  CategoryListStrings.nonAlcoholic,
                                  CategoryListStrings.mixing]
    
    private let triedCocktailSelectionUsecase: TriedCocktailSelectionUsecase
    
    init( triedCocktailSelectionUsecase: TriedCocktailSelectionUsecase) {
        self.triedCocktailSelectionUsecase = triedCocktailSelectionUsecase
    }

    func fetchTriedCocktail() {
        
    }
    
    func filterCocktail(cocktailList: [TriedCocktailInformation], categoryName: String) -> [TriedCocktailInformation] {
        let filteredCocktailList = cocktailList.filter { $0.category == categoryName }
        
        return filteredCocktailList
    }
}
