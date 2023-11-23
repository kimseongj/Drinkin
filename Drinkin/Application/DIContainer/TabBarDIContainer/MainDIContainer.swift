//
//  MainDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class MainDIContainer {
    let provider: Provider
    let cocktailRecommendEndpoint = CocktailRecommendEndpoint()
    
    init(provider: Provider) {
        self.provider = provider
    }
    
    //MARK: - CocktailRecommend
    
    func makeCocktailBriefListRepository() -> CocktailBriefListRepository {
        return DefaultCocktailBriefListRepository(provider: provider,
                                                  endpoint: cocktailRecommendEndpoint)
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        return DefaultCocktailRecommendViewModel(cocktailBriefListRepository: makeCocktailBriefListRepository())
    }
    
    //MARK: - MainViewController
    
    func makeMainViewController() -> MainViewController {
        return MainViewController(viewModel: makeCocktailRecommendViewModel())
    }
}
