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
    
    var categoryList: [String] = ["전체", "위스키 베이스", "리큐르 베이스", "보드카 베이스", "진 베이스", "럼 베이스", "데킬라 베이스", "논알콜", "혼합"]

    func fetchTriedCocktail() {
        
    }
    
    func filterCocktail(cocktailList: [TriedCocktailInformation], categoryName: String) -> [TriedCocktailInformation] {
        let filteredCocktailList = cocktailList.filter { $0.category == categoryName }
        
        return filteredCocktailList
    }
}
