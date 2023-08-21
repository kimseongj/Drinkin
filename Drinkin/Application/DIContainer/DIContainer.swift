//
//  DIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class DIContainer {
    func makeBriefDescriptionRepository() -> BriefDescriptionRepository {
        return DefaultBriefDescriptionRepository()
    }
    
    func makeFetchBriefDescriptionUsecase() -> FetchBriefDescriptionUsecase {
        return DefaultFetchBriefDescriptionUsecase(briefDescriptionRepository: makeBriefDescriptionRepository())
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        return DefaultCocktailRecommendViewModel(fetchBriefDescriptionUseCase: makeFetchBriefDescriptionUsecase())
    }
}
