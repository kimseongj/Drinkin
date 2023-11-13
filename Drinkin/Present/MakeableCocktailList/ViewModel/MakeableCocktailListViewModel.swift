//
//  MakeableCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

protocol MakeableCocktailListViewModel {
    var makeableCocktailList: [MakeableCocktail] { get }
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { get }
    
    func fetchMakeableCocktailList()
}

final class DefaultMakeableCocktailListViewModel: MakeableCocktailListViewModel {
    private let makeableCocktailListRepository: MakeableCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var makeableCocktailList: [MakeableCocktail] = []
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { $makeableCocktailList }
    
    init(makeableCocktailListRepository: MakeableCocktailListRepository) {
        self.makeableCocktailListRepository = makeableCocktailListRepository
    }
    
    func fetchMakeableCocktailList() {
        makeableCocktailListRepository.fetchMakeableCocktails().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            
            self.makeableCocktailList = $0.makeableCocktailList
        }).store(in: &cancelBag)
    }
}
