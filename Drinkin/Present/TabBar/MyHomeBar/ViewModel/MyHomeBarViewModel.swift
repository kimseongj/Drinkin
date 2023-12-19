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
    func deleteHoldedItem(holdedItemName: String)
}

protocol MyHomeBarViewModelOutput  {
    var isAuthenticated: Bool { get }
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var holdedItemListPublisher: Published<[HoldedItem]>.Publisher { get }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

protocol SyncDataDelegate {
    func synchronizationHoldedItem()
}

typealias MyHomeBarViewModel = MyHomeBarViewModelInput & MyHomeBarViewModelOutput & SyncDataDelegate

class DefaultMyHomeBarViewModel: MyHomeBarViewModel {
    private let holdedItemRepository: HoldedItemRepository
    private let deleteItemUsecase: DeleteItemUsecase
    private let authenticationManager: AuthenticationManager
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var holdedItemList: [HoldedItem] = []
    
    //MARK: - Init
    
    init(holdedItemRepository: HoldedItemRepository,
         deleteItemUsecase: DeleteItemUsecase,
         authenticationManager: AuthenticationManager) {
        self.holdedItemRepository = holdedItemRepository
        self.deleteItemUsecase = deleteItemUsecase
        self.authenticationManager = authenticationManager
    }
    
    //MARK: - Output
    
    var isAuthenticated: Bool = false
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var holdedItemListPublisher: Published<[HoldedItem]>.Publisher { $holdedItemList }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
    
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
    
    func deleteHoldedItem(holdedItemName: String) {
        if let holdedItemIndex = holdedItemList.firstIndex(where: { $0.itemName == holdedItemName}) {
            let willRemoveHoldedItem = holdedItemList.remove(at: holdedItemIndex)
            deleteItemUsecase.delete(holdedItem: willRemoveHoldedItem)
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
                receiveValue: {
                    print($0)
                }
            ).store(in: &cancelBag)
        }
    }
    
    //MARK: - SynchronizationDataDelegate
    func synchronizationHoldedItem() {
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
                }
            ).store(in: &cancelBag)
    }
}
