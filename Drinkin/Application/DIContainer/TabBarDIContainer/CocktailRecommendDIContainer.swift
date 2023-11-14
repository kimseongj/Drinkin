//
//  BriefDescriptionDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class CocktailRecommendDIContainer {
    let provider: Provider
    let cocktailRecommendEndpoint = CocktailRecommendEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    func makeCocktailBriefListRepository() -> CocktailBriefListRepository {
        return DefaultCocktailBriefListRepository(provider: provider,
                                                  endpoint: cocktailRecommendEndpoint)
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        return DefaultCocktailRecommendViewModel(cocktailBriefListRepository: makeCocktailBriefListRepository())
    }
}
