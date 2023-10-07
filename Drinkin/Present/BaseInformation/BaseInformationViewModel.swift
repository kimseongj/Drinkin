//
//  BaseInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation
import Combine

protocol BaseInformationViewModel {
    var baseBrandListPublisher: Published<[BrandDescription]>.Publisher { get }
}

final class DefaultBaseInformationViewModel: BaseInformationViewModel {
    private let fetchBaseDescriptionUsecase: FetchBaseDescriptionUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var baseBrandList: [BrandDescription] = []
    var baseBrandListPublisher: Published<[BrandDescription]>.Publisher { $baseBrandList }
    
    init(fetchBaseDescriptionUsecase: FetchBaseDescriptionUsecase) {
        self.fetchBaseDescriptionUsecase = fetchBaseDescriptionUsecase
    }
    
    func fetchBaseBrandDesription() {
        
    }
}

