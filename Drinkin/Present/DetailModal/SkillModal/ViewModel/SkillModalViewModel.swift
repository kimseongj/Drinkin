//
//  SkillModalViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/28.
//

import Foundation
import Combine

protocol SkillModalViewModel {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    
    func fetchSkillDetail(completion: @escaping (SkillDetail) -> Void)
}

final class DefaultSkillModalViewModel: SkillModalViewModel {
    private let skillDetailRepository: SkillDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    
    init(skillDetailRepository: SkillDetailRepository) {
        self.skillDetailRepository = skillDetailRepository
    }
    
    func fetchSkillDetail(completion: @escaping (SkillDetail) -> Void) {
        skillDetailRepository.fetchSkillDetail().receive(on: RunLoop.main)
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
