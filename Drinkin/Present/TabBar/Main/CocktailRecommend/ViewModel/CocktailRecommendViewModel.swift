//
//  LoggedinMainViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/07/22.
//

import Foundation
import Combine

protocol CocktailRecommendViewModelInput {
    func fetchBriefDescription(completion: @escaping () -> Void)
}

protocol CocktailRecommendViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { get }
}

typealias CocktailRecommendViewModel = CocktailRecommendViewModelInput & CocktailRecommendViewModelOutput

class DefaultCocktailRecommendViewModel: CocktailRecommendViewModel {
    private let cocktailBriefListRepository: CocktailBriefListRepository
    private let synchronizationManager: SynchronizationManager
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var briefDescriptionList: [CocktailBrief] = []
    
    //MARK: - Init
    
    init(cocktailBriefListRepository: CocktailBriefListRepository,
         synchronizationManager: SynchronizationManager) {
        self.cocktailBriefListRepository = cocktailBriefListRepository
        self.synchronizationManager = synchronizationManager
        
        synchronizeData()
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var briefDescriptionListPublisher: Published<[CocktailBrief]>.Publisher { $briefDescriptionList }
    
    //MARK: - Input
    
    func fetchBriefDescription(completion: @escaping () -> Void) {
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
                    completion()
                }).store(in: &cancelBag)
    }
}

//MARK: - Synchronizing

extension DefaultCocktailRecommendViewModel {
    func synchronizeData() {
        synchronizationManager.dataChangeStatusPublisher()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                guard let self = self else { return }
                if $0 == true {
                    self.fetchBriefDescription {
                        self.synchronizationManager.initialize()
                    }
                }
            }.store(in: &cancelBag)
    }
}
