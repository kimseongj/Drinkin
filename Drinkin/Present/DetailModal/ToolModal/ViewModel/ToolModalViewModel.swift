//
//  ToolModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol ToolModalViewModel {
    func fetchToolDetail(completion: @escaping (ToolDetailResult) -> Void)
}

final class DefaultToolModalViewModel: ToolModalViewModel {
    private let toolDetailRepository: ToolDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var toolDetail: ToolDetailResult?
    
    init(toolDetailRepository: ToolDetailRepository) {
        self.toolDetailRepository = toolDetailRepository
    }
    
    func fetchToolDetail(completion: @escaping (ToolDetailResult) -> Void) {
        toolDetailRepository.fetchToolDetail().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            completion($0.result)
        }).store(in: &cancelBag)
    }
}
