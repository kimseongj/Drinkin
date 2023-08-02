//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine

protocol CocktailRecommendViewModel {
    var briefDescriptionListPublisher: Published<[BriefDescription]>.Publisher { get }
    
    func fetchBriefDescription()
}

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    @Published var briefDescriptionList: [BriefDescription] = []
    
    var briefDescriptionListPublisher: Published<[BriefDescription]>.Publisher { $briefDescriptionList }
    
    private var cancelBag: Set<AnyCancellable> = []
    
    private let fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase
    
    init(fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase) {
        self.fetchBriefDescriptionUseCase = fetchBriefDescriptionUseCase
    }
    
    func fetchBriefDescription() {
        fetchBriefDescriptionUseCase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.briefDescriptionList = $0.briefDescriptionList
            
        }).store(in: &cancelBag)
    }
}