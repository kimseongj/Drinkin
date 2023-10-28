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
    let brandID: Int
    
    init(tokenManager: TokenManager, provider: Provider, endpoint: EndpointMakeable, brandID: Int) {
        self.tokenManager = tokenManager
        self.provider = provider
        self.endpoint = endpoint
        self.brandID = brandID
    }
    
    func fetchBaseBrandDetail() -> AnyPublisher<BaseBrandDetail, Error> {
        //endpoint.insertQuery(queryParameter: "brand_id", queryValue: brandID.description)
        return provider.fetchData(endpoint: endpoint)
    }
}
