//
//  ProductDetailDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/29.
//

import Foundation

final class ProductDetailDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
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
