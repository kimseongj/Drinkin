//
//  BaseBrandInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

protocol BaseBrandInformationViewModelIntput {
    func fetchBaseBrandDetail()
}

protocol BaseBrandInformationViewModelOutput {
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { get }
    var brandID: Int { get set }
}

typealias BaseBrandInformationViewModel = BaseBrandInformationViewModelIntput & BaseBrandInformationViewModelOutput

final class DefaultBaseBrandInformationViewModel: BaseBrandInformationViewModel {
    private let baseBrandDetailRepository: BaseBrandDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseBrandDetail: BaseBrandDetail?
    
    //MARK: - Init
    init(baseBrandDetailRepository: BaseBrandDetailRepository) {
        self.baseBrandDetailRepository = baseBrandDetailRepository
    }
    
    //MARK: - Output
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { $baseBrandDetail }
    var brandID: Int = 0
    
    //MARK: - Input
    func fetchBaseBrandDetail() {
        baseBrandDetailRepository.fetchBaseBrandDetail()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                self.baseBrandDetail = $0
                self.brandID = $0.id
                
            }).store(in: &cancelBag)
    }
}

