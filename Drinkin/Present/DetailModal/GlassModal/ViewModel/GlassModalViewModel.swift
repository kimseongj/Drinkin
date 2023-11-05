//
//  GlassModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol GlassModalViewModel {
    func fetchGlassDetail(completion: @escaping (GlassDetail) -> Void)
}

final class DefaultGlassModalViewModel: GlassModalViewModel {
    private let glassDetailRepository: GlassDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    init(glassDetailRepository: GlassDetailRepository) {
        self.glassDetailRepository = glassDetailRepository
    }
    
    func fetchGlassDetail(completion: @escaping (GlassDetail) -> Void) {
        glassDetailRepository.fetchGlassDetail().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            completion($0)
        }).store(in: &cancelBag)
    }
}
