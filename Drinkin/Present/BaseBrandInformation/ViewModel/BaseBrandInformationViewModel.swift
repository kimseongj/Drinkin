//
//  BaseBrandInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/18.
//

import Foundation
import Combine

protocol BaseBrandInformationViewModelIntput {
    func fetchBaseBrandDetail(completion: @escaping () -> Void)
}

protocol BaseBrandInformationViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { get }
    var brandID: Int { get set }
}

typealias BaseBrandInformationViewModel = BaseBrandInformationViewModelIntput & BaseBrandInformationViewModelOutput

final class DefaultBaseBrandInformationViewModel: BaseBrandInformationViewModel {
    private let baseBrandDetailRepository: BaseBrandDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var baseBrandDetail: BaseBrandDetail?
    
    //MARK: - Init
    
    init(baseBrandDetailRepository: BaseBrandDetailRepository) {
        self.baseBrandDetailRepository = baseBrandDetailRepository
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var baseBrandDetailPublisher: Published<BaseBrandDetail?>.Publisher { $baseBrandDetail }
    var brandID: Int = 0
    
    //MARK: - Input
    
    func fetchBaseBrandDetail(completion: @escaping () -> Void) {
        baseBrandDetailRepository.fetchBaseBrandDetail()
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
                    self.baseBrandDetail = $0
                    self.brandID = $0.id
                    completion()
                }
            ).store(in: &cancelBag)
    }
}

