//
//  ToolDetailRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Combine

protocol ToolDetailRepository {
    func fetchToolDetail() -> AnyPublisher<ToolDetail, Error>
}
