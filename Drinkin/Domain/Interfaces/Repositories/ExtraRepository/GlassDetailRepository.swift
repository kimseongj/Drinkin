//
//  GlassDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

protocol GlassDetailRepository {
    func fetchGlassDetail() -> AnyPublisher<GlassDetail, Error>
}
