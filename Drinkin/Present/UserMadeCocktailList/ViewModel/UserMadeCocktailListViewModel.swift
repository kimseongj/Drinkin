//
//  UserMadeCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListViewModelInput {
    func fetchCocktailPreviewDescription()
}

protocol UserMadeCocktailListViewModelOutput {
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { get }
}

typealias UserMadeCocktailListViewModel = UserMadeCocktailListViewModelInput & UserMadeCocktailListViewModelOutput

final class DefaultUserMadeCocktailListViewModel: UserMadeCocktailListViewModel {
    private let userMadeCocktailListRepository: UserMadeCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []

    @Published var previewDescriptionList: [CocktailPreview] = []
    
    //MARK: - Init
    init(userMadeCocktailListRepository: UserMadeCocktailListRepository) {
        self.userMadeCocktailListRepository = userMadeCocktailListRepository
    }
    
    //MARK: - Output
    var previewDescriptionListPublisher: Published<[CocktailPreview]>.Publisher { $previewDescriptionList }
    
    //MARK: - Input
    func fetchCocktailPreviewDescription() {
        userMadeCocktailListRepository.fetchUserMadeCocktailList()
            .sink(receiveCompletion: { print("\($0)")},
                  receiveValue: { [weak self] in
                guard let self = self else { return }
                
                self.previewDescriptionList = $0.cocktailList
            }).store(in: &cancelBag)
    }
}
