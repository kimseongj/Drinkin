//
//  DefaultBaseBrandDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

final class DefaultBaseBrandDetailRepository: BaseBrandDetailRepository {
    let provider: Provider
    var endpoint: EndpointMakeable
    let brandID: Int
    
    init(provider: Provider, endpoint: EndpointMakeable, brandID: Int) {
        self.provider = provider
        self.endpoint = endpoint
        self.brandID = brandID
    }
    
    func fetchBaseBrandDetail() -> AnyPublisher<BaseBrandDetail, Error> {
        endpoint.insertPathParmeter(pathParameter: brandID.description)
        
        return provider.fetchData(endpoint: endpoint)
    }
}
