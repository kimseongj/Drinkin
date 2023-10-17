//
//  BaseInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation
import Combine

protocol BaseInformationViewModel {
    var baseDescriptionPublisher: Published<BaseDescription?>.Publisher { get }
    
    func fetchBaseDesription()
}

final class DefaultBaseInformationViewModel: BaseInformationViewModel {
    private let baseDescriptionRepository: BaseDescriptionRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseDescription: BaseDescription?
    var baseDescriptionPublisher: Published<BaseDescription?>.Publisher { $baseDescription }
    
    init(baseDescriptionRepository: BaseDescriptionRepository) {
        self.baseDescriptionRepository = baseDescriptionRepository
    }
    
    func fetchBaseDesription() {
        baseDescriptionRepository.fetchBaseDescription().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.baseDescription = $0
        }).store(in: &cancelBag)
    }
}

