//
//  BaseInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/07.
//

import Foundation

final class BaseInformationDIContainer {
    let provider: Provider
    let baseID: Int
    let baseInformationEndpoint = BaseInformationEndpoint()
    
    init(provider: Provider, baseID: Int) {
        self.provider = provider
        self.baseID = baseID
    }
    
    func makeBaseDetailRepository() -> BaseDetailRepository {
        DefaultBaseDetailRepository(provider: provider,
                                           endpoint: baseInformationEndpoint,
                                           baseID: baseID)
    }
    
    func makeBaseInformationViewModel() -> BaseInformationViewModel {
        DefaultBaseInformationViewModel(baseDetailRepository: makeBaseDetailRepository())
    }
    
    func makeBaseInformationViewController() -> BaseInformationViewController {
        BaseInformationViewController(viewModel: makeBaseInformationViewModel())
    }
}
