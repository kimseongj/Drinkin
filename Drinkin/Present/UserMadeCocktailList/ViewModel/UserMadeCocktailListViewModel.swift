//
//  UserMadeCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListViewModel {
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }
    
    func fetchCocktailPreviewDescription()
}

final class DefaultUserMadeCocktailListViewModel: UserMadeCocktailListViewModel {
    private let userMadeCocktailListRepository: UserMadeCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var previewDescriptionList: [CocktailPreview] = []
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    init(userMadeCocktailListRepository: UserMadeCocktailListRepository) {
        self.userMadeCocktailListRepository = userMadeCocktailListRepository
    }
    
    func fetchCocktailPreviewDescription() {
        userMadeCocktailListRepository.fetchUserMadeCocktailList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                
                self.previewDescriptionList = $0.cocktailList
            }).store(in: &cancelBag)
    }
}
