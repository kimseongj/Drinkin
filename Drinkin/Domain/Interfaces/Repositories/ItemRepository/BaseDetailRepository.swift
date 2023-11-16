//
//  BaseDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol BaseDetailRepository {
    func fetchBaseDetail() -> AnyPublisher<BaseDetail, APIError>
}
