//
//  UsecaseUnitTests.swift
//  UsecaseUnitTests
//
//  Created by kimseongjun on 2023/12/27.
//

import XCTest
import Combine
@testable import Drinkin

final class FilterTriedCocktailUsecaseTests: XCTestCase {
    private var mockCocktailImageListRepository: CocktailImageListRepository!
    private var filterTriedCocktailUsecase: FilterTriedCocktailUsecase!
    
    private var cancelBag: Set<AnyCancellable> = []
    
    
    override func setUpWithError() throws {
        mockCocktailImageListRepository = MockCocktailImageListRepository()
        filterTriedCocktailUsecase = DefaultFilterTriedCocktailUsecase(cocktailImageListRepository: mockCocktailImageListRepository)
    }
    
    override func tearDownWithError() throws {
        mockCocktailImageListRepository = nil
        filterTriedCocktailUsecase = nil
    }
    
    func test_fetch_success_CocktailImageList() {
        //given
        let expectation = [ImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: ""),
                           ImageDescription(id: 3, category: "진 베이스", cocktailNameKo: "네그로니 사워", imageURI: "")]
        var result: [ImageDescription] = []
        
        //when
        filterTriedCocktailUsecase.fetchCocktailImageList()
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                result = $0.cocktailImageList
            }).store(in: &cancelBag)
        
        //then
        XCTAssertEqual(expectation, result)
    }
    
    func test_filter_Cocktail() {
        //given
        let inputCategory = "리큐르 베이스"
        let inputSelectableCocktailList =
        [SelectableImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: ""),
         SelectableImageDescription(id: 3, category: "진 베이스", cocktailNameKo: "네그로니 사워", imageURI: "")]
        
        let expectation = [SelectableImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: "")]
        
        //when
        let result = filterTriedCocktailUsecase.filterCocktail(cocktailCategory: "리큐르 베이스",
                                                               selectableCocktailList: inputSelectableCocktailList)
        
        //then
        XCTAssertEqual(expectation, result)
    }
    
    func test_filter_cocktail_is_whole() {
        //given
        let inputCategory = "전체"
        let inputSelectableCocktailList =
        [SelectableImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: ""),
         SelectableImageDescription(id: 3, category: "진 베이스", cocktailNameKo: "네그로니 사워", imageURI: "")]
        
        let expectation =
        [SelectableImageDescription(id: 2, category: "리큐르 베이스", cocktailNameKo: "가리발디", imageURI: ""),
         SelectableImageDescription(id: 3, category: "진 베이스", cocktailNameKo: "네그로니 사워", imageURI: "")]
        
        //when
        let result = filterTriedCocktailUsecase.filterCocktail(cocktailCategory: "전체",
                                                               selectableCocktailList: inputSelectableCocktailList)
        
        //then
        XCTAssertEqual(expectation, result)
        
    }
}
