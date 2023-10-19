//
//  BaseBrandInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

protocol BaseBrandInformationViewModel {
    var baseBrandDetailPublisher: Published<BrandDetail?>.Publisher { get }
    
    func fetchBaseBrandDetail()
}

final class DefaultBaseBrandInformationViewModel: BaseBrandInformationViewModel {
    private let baseBrandDetailRepository: BaseBrandDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseBrandDetail: BrandDetail?
    var baseBrandDetailPublisher: Published<BrandDetail?>.Publisher { $baseBrandDetail }
    
    init(baseBrandDetailRepository: BaseBrandDetailRepository) {
        self.baseBrandDetailRepository = baseBrandDetailRepository
    }
    
    func fetchBaseBrandDetail() {
        baseBrandDetailRepository.fetchBaseBrandDetail().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.baseBrandDetail = $0.brandDetail
        }).store(in: &cancelBag)
    }
}

