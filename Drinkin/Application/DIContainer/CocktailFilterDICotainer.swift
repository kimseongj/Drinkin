//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeCocktailFilterRepository() -> CocktailFilterRepository {
        return DefaultCocktailFilterRepository()
    }
    
    func makeFetchCocktailFilterUsecase() -> FetchCocktailFilterUsecase {
        return DefaultFetchCocktailFilterUsecase(cocktailFilterRepository: makeCocktailFilterRepository())
    }
    
    func makePreviewDescriptionRepository() -> PreviewDescriptionRepository {
        return DefaultPreviewDescriptionRepository()
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
