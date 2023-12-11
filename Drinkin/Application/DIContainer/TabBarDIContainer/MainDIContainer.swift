//
//  MainDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class MainDIContainer {
    private let provider: Provider
    private let loginManager: LoginManager
    private let cocktailRecommendEndpoint = CocktailRecommendEndpoint()
    
    init(provider: Provider, loginManager: LoginManager) {
        self.provider = provider
        self.loginManager = loginManager
    }
    
    //MARK: - CocktailRecommend
    
    func makeCocktailBriefListRepository() -> CocktailBriefListRepository {
        DefaultCocktailBriefListRepository(provider: provider,
                                           endpoint: cocktailRecommendEndpoint)
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        DefaultCocktailRecommendViewModel(cocktailBriefListRepository: makeCocktailBriefListRepository())
    }
    
    //MARK: - MainViewController
    
    func makeMainViewController() -> MainViewController {
        MainViewController(viewModel: makeCocktailRecommendViewModel(),
                           loginManager: loginManager)
    }
}
