//
//  MakeableCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

protocol MakeableCocktailListViewModel {
    
}

final class DefaultMakeableCocktailListViewModel: MakeableCocktailListViewModel {
    private let makeableCocktailListRepository: MakeableCocktailListRepository
    
    init(makeableCocktailListRepository: MakeableCocktailListRepository) {
        self.makeableCocktailListRepository = makeableCocktailListRepository
    }
    
    func fetchMakeableCocktailList() {
        
    }
}
