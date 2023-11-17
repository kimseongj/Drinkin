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
        return DefaultBaseDetailRepository(provider: provider,
                                           endpoint: baseInformationEndpoint,
                                           baseID: baseID)
    }
    
    func makeBaseInformationViewModel() -> BaseInformationViewModel {
        return DefaultBaseInformationViewModel(baseDetailRepository: makeBaseDetailRepository())
    }
    
    func makeBaseInformationViewController() -> BaseInformationViewController {
        return BaseInformationViewController(viewModel: makeBaseInformationViewModel())
    }
}
