//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine

final class TriedCocktailSelectionViewModel {
    @Published var cocktailList: [String] = []
    let categoryList: [String] = ["전체", "위스키 베이스", "리큐르 베이스", "보드카 베이스", "진 베이스", "럼 베이스", "데킬라 베이스", "논알콜", "혼합"]
    //√var selectedCocktail
    //let baseTypeList: [String] = ["전체", "위스키 베이스", "리큐르 베이스"]
    
//    func isEmptySelectedCocktailList() -> Bool {
//        if selectedCocktailList.count == 0 {
//            return true
//        }
//        return false
//    }
    
    func saveSelectedCocktailList() {
        // 서버 혹은 코어데이터에 저장하기
    }
}
