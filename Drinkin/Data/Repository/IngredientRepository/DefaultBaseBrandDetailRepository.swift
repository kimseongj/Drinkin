//
//  DefaultBaseBrandDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

final class DefaultBaseBrandDetailRepository: BaseBrandDetailRepository {
    let tokenManager: TokenManager
    let provider: Provider
    var endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
    }
    
    func fetchBaseBrandDetail(brandID: Int) -> AnyPublisher<BaseBrandDetail, Error> {
        endpoint.insertQuery(queryParameter: "brand_id", queryValue: brandID.description)
        return provider.fetchData(endpoint: endpoint)
    }
}
