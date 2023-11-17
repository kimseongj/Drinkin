//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine



protocol CocktailRecommendViewModelInput {
    func fetchBriefDescription()
}

protocol CocktailRecommendViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { get }
}

typealias CocktailRecommendViewModel = CocktailRecommendViewModelInput & CocktailRecommendViewModelOutput

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    private let cocktailBriefListRepository: CocktailBriefListRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var briefDescriptionList: [CocktailBrief] = []
    
    //MARK: - Init
    init(cocktailBriefListRepository: CocktailBriefListRepository) {
        self.cocktailBriefListRepository = cocktailBriefListRepository
    }
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { $briefDescriptionList }
    
    //MARK: - Input
    func fetchBriefDescription() {
        cocktailBriefListRepository.fetchCocktailBriefList()
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
                    self.briefDescriptionList = $0.briefDescriptionList
                }).store(in: &cancelBag)
    }
}
