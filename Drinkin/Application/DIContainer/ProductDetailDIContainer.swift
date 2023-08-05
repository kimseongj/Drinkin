//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {

}

//MARK: - Description
extension ProductDetailDIContainer {
    func makeDescriptionRepository(cocktailID: Int) -> DescriptionRepository {
        return DefaultDescriptionRepository(cocktailID: cocktailID)
    }
    
    func makeFetchDescriptionUsecase(cocktailID: Int) -> FetchDescriptionUsecase {
        return DefaultFetchDescriptionUsecase(descriptionRepository: makeDescriptionRepository(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewModel(cocktailID: Int) -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(fetchDescriptionUseCase: makeFetchDescriptionUsecase(cocktailID: cocktailID))
    }
}
