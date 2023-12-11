//
//  DeleteItemUsecase.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/09.
//

import Foundation
import Combine

protocol DeleteItemUsecase {
    func delete(holdedItem: HoldedItem) -> AnyPublisher<PostResponse, APIError>
}

final class DefaultDeleteItemUsecase: DeleteItemUsecase {
    private let deletionRepository: DeletionRepository
    
    init(deletionRepository: DeletionRepository) {
        self.deletionRepository = deletionRepository
    }
    
    func delete(holdedItem: HoldedItem) -> AnyPublisher<PostResponse, APIError> {
        return deletionRepository.delete(holdedItem: holdedItem)
    }
}
