//
//  MakeableCocktailListViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/27.
//

import Foundation
import Combine

protocol MakeableCocktailListViewModelInput {
    func fetchMakeableCocktailList()
}

protocol MakeableCocktailListViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var makeableCocktailList: [MakeableCocktail] { get }
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { get }
}

typealias MakeableCocktailListViewModel = MakeableCocktailListViewModelInput & MakeableCocktailListViewModelOutput

final class DefaultMakeableCocktailListViewModel: MakeableCocktailListViewModel {
    private let makeableCocktailListRepository: MakeableCocktailListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    
    //MARK: - Init
    init(makeableCocktailListRepository: MakeableCocktailListRepository) {
        self.makeableCocktailListRepository = makeableCocktailListRepository
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    @Published var makeableCocktailList: [MakeableCocktail] = []
    var makeableCocktailListPublisher: Published<[MakeableCocktail]>.Publisher { $makeableCocktailList }
    
    //MARK: - Input
    func fetchMakeableCocktailList() {
        makeableCocktailListRepository.fetchMakeableCocktails()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .failure(let error):
                        switch error {
                        case .unauthorized:
                            self.errorType = .unauthorized
                        case .notFound:
                            self.errorType = .notFound
                        case .networkError(_):
                            self.errorType = .networkError(error)
                        case .decodingError:
                            self.errorType = .decodingError
                        case .refreshTokenExpired:
                            self.errorType = .refreshTokenExpired
                        case .noError:
                            break
                        }
                    case .finished:
                        return
                    }
                },
                receiveValue: { [weak self] in
                    guard let self = self else { return }
                    
                    self.makeableCocktailList = $0.makeableCocktailList
                }
            ).store(in: &cancelBag)
    }
}
