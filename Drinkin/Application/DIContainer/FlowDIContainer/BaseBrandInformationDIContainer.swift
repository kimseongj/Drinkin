//
//  BaseBrandInformationDIContainer.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation

final class BaseBrandInformationDIContainer {
    let provider: Provider
    let brandID: Int
    let baseBrandInformationEndpoint = BaseBrandInformationEndpoint()
    
    init(provider: Provider, brandID: Int) {
        self.provider = provider
        self.brandID = brandID
    }
    
    func makeBaseBrandDetailRepository() -> BaseBrandDetailRepository {
        return DefaultBaseBrandDetailRepository(provider: provider,
                                                endpoint: baseBrandInformationEndpoint,
                                                brandID: brandID)
    }
    
    func makeBaseBrandInformationViewModel() -> BaseBrandInformationViewModel {
        return DefaultBaseBrandInformationViewModel(baseBrandDetailRepository: makeBaseBrandDetailRepository())
    }
    
    func makeBaseBrandInformationViewController() -> BaseBrandInformationViewController {
        return BaseBrandInformationViewController(viewModel: makeBaseBrandInformationViewModel())
    }
}
