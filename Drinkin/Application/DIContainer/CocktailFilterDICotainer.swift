//
//  CocktailFilterDICotainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/17.
//

import Foundation

final class CocktailFilterDICotainer {
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
}
