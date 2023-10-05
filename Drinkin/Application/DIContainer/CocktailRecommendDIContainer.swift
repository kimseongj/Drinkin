//
//  BriefDescriptionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class CocktailRecommendDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
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
