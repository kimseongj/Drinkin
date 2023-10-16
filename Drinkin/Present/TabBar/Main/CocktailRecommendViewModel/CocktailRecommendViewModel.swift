//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine

protocol CocktailRecommendViewModel {
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { get }
    
    func fetchBriefDescription()
}

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    private let cocktailBriefListRepository: CocktailBriefListRepository
    @Published var briefDescriptionList: [CocktailBrief] = []
    
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { $briefDescriptionList }
    
    init(cocktailBriefListRepository: CocktailBriefListRepository) {
        self.cocktailBriefListRepository = cocktailBriefListRepository
    }
    
    func fetchBriefDescription() {
        cocktailBriefListRepository.fetchCocktailBriefList().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.briefDescriptionList = $0.briefDescriptionList
        }).store(in: &cancelBag)
    }
}
