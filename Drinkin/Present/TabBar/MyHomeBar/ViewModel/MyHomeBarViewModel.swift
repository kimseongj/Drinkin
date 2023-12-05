//
//  MyHomeBarViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/08/31.
//

import Foundation
import Combine

protocol MyHomeBarViewModelInput {
    func fetchHoldedItem(completion: @escaping () -> Void)
    func deleteHoldedItem(holdedItem: String)
}

protocol MyHomeBarViewModelOutput  {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var holdedItemListPublisher: Published<[String]>.Publisher { get }
}

typealias MyHomeBarViewModel = MyHomeBarViewModelInput & MyHomeBarViewModelOutput

class DefaultMyHomeBarViewModel: MyHomeBarViewModel {
    private let holdedItemRepository: HoldedItemRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var holdedItemList: [String] = []
    
    //MARK: - Init
    
    init(holdedItemRepository: HoldedItemRepository) {
        self.holdedItemRepository = holdedItemRepository
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var holdedItemListPublisher: Published<[String]>.Publisher { $holdedItemList }
    
    //MARK: - Input
    
    func fetchHoldedItem(completion: @escaping () -> Void) {
        holdedItemRepository.fetchHoldedItem()
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
                    self.holdedItemList = $0.holdedItemList
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    func deleteHoldedItem(holdedItem: String) {
        if let index = holdedItemList.firstIndex(of: holdedItem) {
            holdedItemList.remove(at: index)
        }
    }
}
