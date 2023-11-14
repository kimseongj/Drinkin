//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine



protocol CocktailRecommendViewModelInput {
    func fetchBriefDescription()
}

protocol CocktailRecommendViewModelOutput {
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { get }
}

typealias CocktailRecommendViewModel = CocktailRecommendViewModelInput & CocktailRecommendViewModelOutput

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    private let cocktailBriefListRepository: CocktailBriefListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var briefDescriptionList: [CocktailBrief] = []
    
    //MARK: - Init
    init(cocktailBriefListRepository: CocktailBriefListRepository) {
        self.cocktailBriefListRepository = cocktailBriefListRepository
    }
    
    //MARK: - Output
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { $briefDescriptionList }
    
    //MARK: - Input
    func fetchBriefDescription() {
        cocktailBriefListRepository.fetchCocktailBriefList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                self.briefDescriptionList = $0.briefDescriptionList
            }).store(in: &cancelBag)
    }
}
