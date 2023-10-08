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
    private let fetchBaseDescriptionUsecase: FetchBaseDescriptionUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseDescription: BaseDescription?
    var baseDescriptionPublisher: Published<BaseDescription?>.Publisher { $baseDescription }
    
    init(fetchBaseDescriptionUsecase: FetchBaseDescriptionUsecase) {
        self.fetchBaseDescriptionUsecase = fetchBaseDescriptionUsecase
    }
    
    func fetchBaseDesription() {
        fetchBaseDescriptionUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.baseDescription = $0
        }).store(in: &cancelBag)
    }
}

