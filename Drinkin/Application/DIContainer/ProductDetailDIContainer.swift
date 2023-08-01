//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {

}


//MARK: - BriefDescription
extension ProductDetailDIContainer {
    func makeDescriptionRepository() -> DescriptionRepository {
        return DefaultDescriptionRepository()
    }
    
    func makeFetchDescriptionUsecase() -> FetchDescriptionUsecase {
        return DefaultFetchDescriptionUsecase(descriptionRepository: makeDescriptionRepository())
    }
    
//    func makeCocktailRecommendViewModel() -> CocktailRecommendViewModel {
//        return DefaultCocktailRecommendViewModel(fetchBriefDescriptionUseCase: makeFetchBriefDescriptionUsecase())
//    }
}
