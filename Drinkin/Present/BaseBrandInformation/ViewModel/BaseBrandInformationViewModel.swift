//
//  BaseBrandInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

protocol BaseBrandInformationViewModel {
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { get }
    
    func fetchBaseBrandDetail()
}

final class DefaultBaseBrandInformationViewModel: BaseBrandInformationViewModel {
    private let baseBrandDetailRepository: BaseBrandDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseBrandDetail: BaseBrandDetail?
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { $baseBrandDetail }
    
    init(baseBrandDetailRepository: BaseBrandDetailRepository) {
        self.baseBrandDetailRepository = baseBrandDetailRepository
    }
    
    func fetchBaseBrandDetail() {
        baseBrandDetailRepository.fetchBaseBrandDetail().sink(receiveCompletion: { print("\($0)")}, receiveValue: { [weak self] in
            guard let self = self else { return }
            
            self.baseBrandDetail = $0
        }).store(in: &cancelBag)
    }
}

