//
//  MockCocktailImageListRepository.swift
//  UsecaseUnitTests
//
//  Created by kimseongjun on 2023/12/27.
//

import Combine
@testable import Drinkin

final class MockCocktailImageListRepository: CocktailImageListRepository {
    var result: Result<Drinkin.CocktailImageList, Drinkin.APIError> =
        .success(CocktailImageList(cocktailImageList: [
            ImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: ""),
            ImageDescription(id: 3, category: "진 베이스", cocktailNameKo: "네그로니 사워", imageURI: "")
            ]))
    
    func fetchCocktailImageList() -> AnyPublisher<Drinkin.CocktailImageList, Drinkin.APIError> {
        return result.publisher.eraseToAnyPublisher()
    }
}
