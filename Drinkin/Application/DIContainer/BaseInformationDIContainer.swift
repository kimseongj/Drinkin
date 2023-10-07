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
    
    func makeBaseDescriptionRepository() -> BaseDescriptionRepository {
        return DefaultBaseDescriptionRepository(tokenManager: dependencies.tokenManager,
                                                     provider: dependencies.provider,
                                                     endpoint: baseInformationEndpoint)
    }
    
    func makeFetchBaseDescriptionUsecase() -> FetchBaseDescriptionUsecase {
        return DefaultFetchBaseDescriptionUsecase(baseDescriptionRepository: makeBaseDescriptionRepository())
    }
    
    func makeBaseInformationViewModel() -> BaseInformationViewModel {
        return DefaultBaseInformationViewModel(fetchBaseDescriptionUsecase: makeFetchBaseDescriptionUsecase())
    }
    
    func makeBaseInformationViewController() -> BaseInformationViewController {
        return BaseInformationViewController(viewModel: makeBaseInformationViewModel())
    }
}
