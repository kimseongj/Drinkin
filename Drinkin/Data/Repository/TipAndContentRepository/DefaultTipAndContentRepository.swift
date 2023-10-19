//
//  DefaultTipAndContentRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

final class DefaultTipAndContentRepository: TipAndContentRepository {
    let provider = Provider()
    let endpoint = TipAndContentListEndpoint()
    
    func fetchtTipAndContentList() -> AnyPublisher<TipAndContentList, Error> {
        return provider.fetchData(endpoint: endpoint)
    }
}
