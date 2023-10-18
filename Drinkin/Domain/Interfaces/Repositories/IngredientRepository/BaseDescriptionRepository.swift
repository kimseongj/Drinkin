//
//  BaseDescriptionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/17.
//

import Combine

protocol BaseDescriptionRepository {
    func fetchBaseDescription() -> AnyPublisher<BaseDetail, Error>
}
