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
    let cocktailRecommendEndpoint = CocktailRecommendEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCocktailBriefListRepository() -> CocktailBriefListRepository {
        return DefaultCocktailBriefListRepository(tokenManager: dependencies.tokenManager,
                                                 provider: dependencies.provider,
                                                 endpoint: cocktailRecommendEndpoint)
    }
        
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        return DefaultCocktailRecommendViewModel(cocktailBriefListRepository: makeCocktailBriefListRepository())
    }
}
