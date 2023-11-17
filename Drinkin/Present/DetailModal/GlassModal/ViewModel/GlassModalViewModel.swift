//
//  GlassModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol GlassModalViewModel {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    
    func fetchGlassDetail(completion: @escaping (GlassDetail) -> Void)
}

final class DefaultGlassModalViewModel: GlassModalViewModel {
    private let glassDetailRepository: GlassDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    
    init(glassDetailRepository: GlassDetailRepository) {
        self.glassDetailRepository = glassDetailRepository
    }
    
    func fetchGlassDetail(completion: @escaping (GlassDetail) -> Void) {
        glassDetailRepository.fetchGlassDetail()
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
