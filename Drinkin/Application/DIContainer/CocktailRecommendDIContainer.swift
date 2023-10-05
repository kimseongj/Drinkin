//
//  BriefDescriptionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class CocktailRecommendDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
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
