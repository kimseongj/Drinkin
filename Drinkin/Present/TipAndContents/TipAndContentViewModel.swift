//
//  TipAndContentViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

protocol TipAndContentViewModel {
    var tipAndContentListPublisher: Published<[TipAndContent]>.Publisher { get }
    
    func fetchTipAndContentList()
}

final class DefaultTipAndContentViewModel: TipAndContentViewModel {
    private let tipAndContentRepository: TipAndContentRepository = DefaultTipAndContentRepository()
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var tipAndContentList: [TipAndContent] = []
    var tipAndContentListPublisher: Published<[TipAndContent]>.Publisher { $tipAndContentList }
    
    func fetchTipAndContentList() {
        tipAndContentRepository.fetchtTipAndContentList().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.tipAndContentList = $0.tipAndContentList 
        }).store(in: &cancelBag)
    }
}
