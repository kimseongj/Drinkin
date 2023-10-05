//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let cocktailFilterEndpoint = CocktailFilterEndpoint()
    let cocktailListEndpoint = CocktailListEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeCocktailFilterRepository() -> CocktailFilterRepository {
        return DefaultCocktailFilterRepository(tokenManager: dependencies.tokenManager, provider: dependencies.provider, endpoint: cocktailFilterEndpoint)
    }
    
    func makeFetchCocktailFilterUsecase() -> FetchCocktailFilterUsecase {
        return DefaultFetchCocktailFilterUsecase(cocktailFilterRepository: makeCocktailFilterRepository())
    }
    
    func makePreviewDescriptionRepository() -> PreviewDescriptionRepository {
        return DefaultPreviewDescriptionRepository(tokenManager: dependencies.tokenManager,
                                                   provider: dependencies.provider,
                                                   endpoint: cocktailListEndpoint)
    }
    
    func makeFetchPreviewDescriptionUsecase() -> FetchPreviewDescriptionUsecase {
        return DefaultFetchPreviewDescriptionUsecase(previewDescriptionRepository: makePreviewDescriptionRepository())
    }
    
    func makeCocktailFilterViewModel() -> CocktailFilterViewModel {
        return DefaultCocktailFilterViewModel(fetchCocktailFilterUsecase: makeFetchCocktailFilterUsecase(), fetchPreviewDescriptionUsecase: makeFetchPreviewDescriptionUsecase())
    }
    
    func makeCocktailFilterViewController() -> CocktailFilterViewController {
        return CocktailFilterViewController(viewModel: makeCocktailFilterViewModel())
    }
}
