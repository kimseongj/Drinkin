//
//  BaseInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation
import Combine

protocol BaseInformationViewModel {
    var baseDetailPublisher: Published<BaseDetail?>.Publisher { get }
    
    func fetchBaseDetail()
    func returnBrandID(index: Int) -> Int
}

final class DefaultBaseInformationViewModel: BaseInformationViewModel {
    private let baseDetailRepository: BaseDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseDetail: BaseDetail?
    var baseDetailPublisher: Published<BaseDetail?>.Publisher { $baseDetail }
    
    init(baseDetailRepository: BaseDetailRepository) {
        self.baseDetailRepository = baseDetailRepository
    }
    
    func fetchBaseDetail() {
        baseDetailRepository.fetchBaseDetail()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
            guard let self = self else { return }
            
            self.baseDetail = $0
        }).store(in: &cancelBag)
    }
    
    func returnBrandID(index: Int) -> Int {
        guard let brandID = baseDetail?.brandList[index].id else { return 0 }
        return brandID
    }
}

