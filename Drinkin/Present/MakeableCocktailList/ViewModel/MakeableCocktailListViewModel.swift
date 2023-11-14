//
//  MakeableCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

protocol MakeableCocktailListViewModelInput {
    func fetchMakeableCocktailList()
}

protocol MakeableCocktailListViewModelOutput {
    var makeableCocktailList: [MakeableCocktail] { get }
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { get }
}

typealias MakeableCocktailListViewModel = MakeableCocktailListViewModelInput & MakeableCocktailListViewModelOutput

final class DefaultMakeableCocktailListViewModel: MakeableCocktailListViewModel {
    private let makeableCocktailListRepository: MakeableCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    //MARK: - Init
    init(makeableCocktailListRepository: MakeableCocktailListRepository) {
        self.makeableCocktailListRepository = makeableCocktailListRepository
    }
    
    //MARK: - Output
    @Published var makeableCocktailList: [MakeableCocktail] = []
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { $makeableCocktailList }
    
    //MARK: - Input
    func fetchMakeableCocktailList() {
        makeableCocktailListRepository.fetchMakeableCocktails()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                
                self.makeableCocktailList = $0.makeableCocktailList
            }).store(in: &cancelBag)
    }
}
