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
    let brandID: Int
    var endpoint: EndpointMakeable
    
    init(tokenManager: TokenManager, provider: Provider, brandID: Int, endpoint: EndpointMakeable) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.brandID = brandID
        self.endpoint = endpoint
    }
    
    func fetchBaseBrandDetail() -> AnyPublisher<BaseBrandDetail, Error> {
        endpoint.insertQuery(queryParameter: "brand_id", queryValue: brandID.description)
        return provider.fetchData(endpoint: endpoint)
    }
}
