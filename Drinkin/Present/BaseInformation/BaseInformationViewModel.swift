//
//  BaseInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/01.
//

import Foundation
import Combine

protocol BaseInformationViewModel {
    var baseBrandListPublisher: Published<[BaseBrandDescription]>.Publisher { get }
}

final class DefaultBaseInformationViewModel: BaseInformationViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published baseBrandList: [BaseBrandDescription] = []
    var baseBrandListPublisher: Published<[BaseBrandDescription]>.Publisher { $baseBrandList }
    
    func fetchBaseBrandDesription() {
        
    }
}

