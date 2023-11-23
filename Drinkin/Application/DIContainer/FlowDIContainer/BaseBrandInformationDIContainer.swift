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
        DefaultBaseBrandDetailRepository(provider: provider,
                                                endpoint: baseBrandInformationEndpoint,
                                                brandID: brandID)
    }
    
    func makeBaseBrandInformationViewModel() -> BaseBrandInformationViewModel {
        DefaultBaseBrandInformationViewModel(baseBrandDetailRepository: makeBaseBrandDetailRepository())
    }
    
    func makeBaseBrandInformationViewController() -> BaseBrandInformationViewController {
        BaseBrandInformationViewController(viewModel: makeBaseBrandInformationViewModel())
    }
}
