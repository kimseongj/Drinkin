//
//  IngredientInformationViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/10.
//

import Foundation
import Combine

protocol IngredientInformationViewModelInput {
    func fetchIngredientDetail(completion: @escaping () -> Void)
    
}

protocol IngredientInformationViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var ingredientDetailPublisher: Published<IngredientDetail?>.Publisher { get }
    var ingredientID: Int { get set }
}

typealias IngredientInformationViewModel = IngredientInformationViewModelInput & IngredientInformationViewModelOutput

final class DefaultIngredientInformationViewModel: IngredientInformationViewModel {
    private let ingredientDetailRepository: IngredientDetailRepository
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    @Published var ingredientDetail: IngredientDetail?
    
    //MARK: - Init
    
    init(ingredientDetailRepository: IngredientDetailRepository) {
        self.ingredientDetailRepository = ingredientDetailRepository
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    var ingredientDetailPublisher: Published<IngredientDetail?>.Publisher { $ingredientDetail }
    var ingredientID: Int = 0
    
    //MARK: - Input
    
    func fetchIngredientDetail(completion: @escaping () -> Void) {
        ingredientDetailRepository.fetchIngredientDetail()
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
                self.ingredientDetail = $0
                self.ingredientID = $0.id
                completion()
            }
        ).store(in: &cancelBag)
}
}
