//
//  BaseBrandInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

final class BaseBrandInformationDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
        let brandID: Int
    }
    
    let dependencies: Dependencies
    let baseBrandInformationEndpoint = BaseBrandInformationEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeBaseBrandDetailRepository() -> BaseBrandDetailRepository {
        return DefaultBaseBrandDetailRepository(tokenManager: dependencies.tokenManager,
                                                provider: dependencies.provider,
                                                endpoint: baseBrandInformationEndpoint,
                                                brandID: dependencies.brandID)
    }
    
    func makeBaseBrandInformationViewModel() -> BaseBrandInformationViewModel {
        return DefaultBaseBrandInformationViewModel(baseBrandDetailRepository: makeBaseBrandDetailRepository())
    }
    
    func makeBaseBrandInformationViewController() -> BaseBrandInformationViewController {
        return BaseBrandInformationViewController(viewModel: makeBaseBrandInformationViewModel())
    }
}
