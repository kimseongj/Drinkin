//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine

protocol CocktailRecommendViewModel {
    
}

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    @Published var resultList: [Result] = []
    private var cancelBag: Set<AnyCancellable> = []
    
    private let fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase
    
    init(fetchBriefDescriptionUseCase: FetchBriefDescriptionUsecase) {
        self.fetchBriefDescriptionUseCase = fetchBriefDescriptionUseCase
        fetchBriefDescription()
    }
    
    func fetchBriefDescription() {
        fetchBriefDescriptionUseCase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.resultList = $0.results
            print($0) }).store(in: &cancelBag)
    }
    
    func fetchResult(completion: @escaping ([Result]) -> Void) {
        $resultList.sink {
            completion($0)
        }.store(in: &cancelBag)
    }
}
