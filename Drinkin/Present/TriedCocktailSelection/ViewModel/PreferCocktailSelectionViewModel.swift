//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine

final class TriedCocktailSelectionViewModel {
    @Published var selectedCocktailList: [String] = []
    
    func isEmptySelectedCocktailList() -> Bool {
        if selectedCocktailList.count == 0 {
            return true
        }
        return false
    }
    
    func saveSelectedCocktailList() {
        // 서버 혹은 코어데이터에 저장하기
    }
    
}
