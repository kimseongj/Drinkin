//
//  DeletionRepository.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/09.
//

import Foundation
import Combine

protocol DeletionRepository {
    func delete(holdedItem: HoldedItem) -> AnyPublisher<PostResponse, APIError>
}
