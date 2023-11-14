//
//  BaseInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation
import Combine

protocol BaseInformationViewModelInput {
    func fetchBaseDetail()
    func returnBrandID(index: Int) -> Int
}

protocol BaseInformationViewModelIOutput {
    var baseDetailPublisher: Published<BaseDetail?>.Publisher { get }
}

typealias BaseInformationViewModel = BaseInformationViewModelInput & BaseInformationViewModelIOutput

final class DefaultBaseInformationViewModel: BaseInformationViewModel {
    private let baseDetailRepository: BaseDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseDetail: BaseDetail?
    
    //MARK: - Init
    init(baseDetailRepository: BaseDetailRepository) {
        self.baseDetailRepository = baseDetailRepository
    }
    
    //MARK: - Output
    var baseDetailPublisher: Published<BaseDetail?>.Publisher { $baseDetail }
    
    //MARK: - Input
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

