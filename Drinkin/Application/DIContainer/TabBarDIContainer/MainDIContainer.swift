//
//  MainDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/27.
//

import Foundation

final class MainDIContainer {
    private let provider: Provider
    private let authenticationManager: AuthenticationManager
    private let synchronizationManager: SynchronizationManager
    private let cocktailRecommendEndpoint = CocktailRecommendEndpoint()
    
    init(provider: Provider,
         authenticationManager: AuthenticationManager,
         synchronizationManager: SynchronizationManager) {
        self.provider = provider
        self.authenticationManager = authenticationManager
        self.synchronizationManager = synchronizationManager
    }
    
    func makeMainViewModel() -> MainViewModel {
        DefaultMainViewModel(authenticationManager: authenticationManager)
    }
    
    //MARK: - CocktailRecommend
    
    func makeCocktailBriefListRepository() -> CocktailBriefListRepository {
        DefaultCocktailBriefListRepository(provider: provider,
                                           endpoint: cocktailRecommendEndpoint)
    }
    
    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
        DefaultCocktailRecommendViewModel(cocktailBriefListRepository: makeCocktailBriefListRepository(),
                                          synchronizationManager: synchronizationManager)
    }
    
    //MARK: - MainViewController
    
    func makeMainViewController() -> MainViewController {
        MainViewController(viewModel: makeMainViewModel(), cocktailRecommendViewModel: makeCocktailRecommendViewModel())
    }
}
