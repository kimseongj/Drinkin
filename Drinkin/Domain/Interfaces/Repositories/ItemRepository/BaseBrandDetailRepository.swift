//
//  BaseBrandDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Combine

protocol BaseBrandDetailRepository {
    func fetchBaseBrandDetail() -> AnyPublisher<BaseBrandDetail, APIError>
}
