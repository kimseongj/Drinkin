//
//  FilterViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/27.
//

import Foundation
import Combine

class FilterViewModel {
    @Published var filteredItems: [FilteredItem] = []
    
    private var cancelBag: Set<AnyCancellable> = []
    
    func filterCocktail() {
        
    }
    
}
