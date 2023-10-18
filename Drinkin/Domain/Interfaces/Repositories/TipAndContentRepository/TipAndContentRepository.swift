//
//  TipAndContentRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Combine

protocol TipAndContentRepository {
    func fetchtTipAndContentList() -> AnyPublisher<TipAndContentList, Error>
}
