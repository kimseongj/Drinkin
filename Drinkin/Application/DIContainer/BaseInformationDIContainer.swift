//
//  BaseInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation

final class BaseInformationDIContainer {
    struct Dependencies {
        let tokenManager: TokenManager
        let provider: Provider
    }
    
    let dependencies: Dependencies
    let baseInformationEndpoint = BaseInformationEndpoint()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeBaseDetailRepository() -> BaseDetailRepository {
        return DefaultBaseDetailRepository(tokenManager: dependencies.tokenManager,
                                                     provider: dependencies.provider,
                                                     endpoint: baseInformationEndpoint)
    }
    
    func makeBaseInformationViewModel() -> BaseInformationViewModel {
        return DefaultBaseInformationViewModel(baseDetailRepository: makeBaseDetailRepository())
    }
    
    func makeBaseInformationViewController() -> BaseInformationViewController {
        return BaseInformationViewController(viewModel: makeBaseInformationViewModel())
    }
}
