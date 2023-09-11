//
//  UserMadeCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import Foundation
import Combine

protocol UserMadeCocktailListViewModel {
    var previewDescriptionListPublisher: Published<[PreviewDescription]>.Publisher { get }

    func fetchCocktailPreviewDescription()
}

class DefaultUserMadeCocktailListViewModel: UserMadeCocktailListViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var previewDescriptionList: [PreviewDescription] = []
    var previewDescriptionListPublisher: Published<[PreviewDescription]>.Publisher { $previewDescriptionList }
    
    
    
    private let fetchUserMadeCocktailListUsecase: FetchUserMadeCocktailListUsecase
    
    init(fetchUserMadeCocktailListUsecase: FetchUserMadeCocktailListUsecase) {
        self.fetchUserMadeCocktailListUsecase = fetchUserMadeCocktailListUsecase
    }
    
    func fetchCocktailPreviewDescription() {
        fetchUserMadeCocktailListUsecase.execute().sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.previewDescriptionList = $0.cocktailList
            
        }).store(in: &cancelBag)
    }
}
