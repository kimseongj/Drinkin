//
//  ToolModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol ToolModalViewModel {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    
    func fetchToolDetail(completion: @escaping (ToolDetail) -> Void)
}

final class DefaultToolModalViewModel: ToolModalViewModel {
    private let toolDetailRepository: ToolDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    
    @Published var toolDetail: ToolDetail?
    
    init(toolDetailRepository: ToolDetailRepository) {
        self.toolDetailRepository = toolDetailRepository
    }
    
    func fetchToolDetail(completion: @escaping (ToolDetail) -> Void) {
        toolDetailRepository.fetchToolDetail()
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
                receiveValue: {
                    completion($0)
                }
            ).store(in: &cancelBag)
    }
}
