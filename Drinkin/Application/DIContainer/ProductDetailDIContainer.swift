//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {
    let tokenManager: TokenManager
    let provider: Provider
    
    init(tokenManager: TokenManager, provider: Provider) {
        self.tokenManager = tokenManager
        self.provider = provider
    }
    
    func makeDescriptionRepository(cocktailID: Int) -> DescriptionRepository {
        return DefaultDescriptionRepository(cocktailID: cocktailID)
    }
    
    func makeFetchDescriptionUsecase(cocktailID: Int) -> FetchDescriptionUsecase {
        return DefaultFetchDescriptionUsecase(descriptionRepository: makeDescriptionRepository(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewModel(cocktailID: Int) -> ProductDetailViewModel {
        return DefaultProductDetailViewModel(fetchDescriptionUseCase: makeFetchDescriptionUsecase(cocktailID: cocktailID))
    }
    
    func makeProductDetailViewController(viewModel: ProductDetailViewModel) -> ProductDetailViewController {
        return ProductDetailViewController(viewModel: viewModel)
    }
}
