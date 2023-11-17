//
//  TriedCocktailSelectionViewModel.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/06/21.
//

import Foundation
import Combine

protocol TriedCocktailSelectionViewModelInput {
    func fetchCocktailImageList()
    func filterCocktailList(cocktailCategoryIndex: Int)
    func selectCocktail(index: Int)
    func deselectCocktail(index: Int)
    func checkCocktailSelected() -> Bool
    func addTriedCocktailList(completion: @escaping () -> Void)
}

protocol TriedCocktailSelectionViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { get }
    var categoryList: [String] { get }
}

typealias TriedCocktailSelectionViewModel = TriedCocktailSelectionViewModelInput & TriedCocktailSelectionViewModelOutput

final class DefaultTriedCocktailSelectionViewModel: TriedCocktailSelectionViewModel {
    private let addTriedCocktailUsecase: AddTriedCocktailUsecase
    private let filterTriedCocktailUsecase: FilterTriedCocktailUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    var selectableCocktailList: [SelectableImageDescription] = []
    @Published var filteredSelectableCocktailList: [SelectableImageDescription] = []
    
    //MARK: - Init
    init(filterTriedCocktailUsecase: FilterTriedCocktailUsecase,
         addTriedCocktailUsecase: AddTriedCocktailUsecase) {
        self.filterTriedCocktailUsecase = filterTriedCocktailUsecase
        self.addTriedCocktailUsecase = addTriedCocktailUsecase
    }
    
    //MARK: - Output
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    
    var categoryList: [String] = [CategoryListStrings.whole,
                                  CategoryListStrings.whiskey,
                                  CategoryListStrings.liqueur,
                                  CategoryListStrings.vodka,
                                  CategoryListStrings.gin,
                                  CategoryListStrings.rum,
                                  CategoryListStrings.tequila,
                                  CategoryListStrings.nonAlcoholic,
                                  CategoryListStrings.mixing]
    
    var filteredSelectableCocktailListPublisher: Published<[SelectableImageDescription]>.Publisher { $filteredSelectableCocktailList }
}

//MARK: - Input
//MARK: - Fetch Data
extension DefaultTriedCocktailSelectionViewModel {
    func fetchCocktailImageList() {
        filterTriedCocktailUsecase.fetchCocktailImageList()
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
                    self.convertSelectableCocktailList(cocktailList: $0.cocktailImageList)
                    self.filteredSelectableCocktailList = self.selectableCocktailList.sorted { $0.cocktailNameKo < $1.cocktailNameKo }
                }
            ).store(in: &cancelBag)
    }
    
    func convertSelectableCocktailList(cocktailList: [ImageDescription]) {
        cocktailList.forEach {
            let convertedImageDescrtipon = SelectableImageDescription(id: $0.id,
                                                                      category: $0.category,
                                                                      cocktailNameKo: $0.cocktailNameKo,
                                                                      imageURI: $0.imageURI)
            selectableCocktailList.append(convertedImageDescrtipon)
        }
    }
}

//MARK: - Filter Cocktail
extension DefaultTriedCocktailSelectionViewModel {
    func filterCocktailList(cocktailCategoryIndex: Int) {
        let cocktailCategory = categoryList[cocktailCategoryIndex]
        filteredSelectableCocktailList = filterTriedCocktailUsecase.filterCocktail(cocktailCategory: cocktailCategory,
                                                                                   selectableCocktailList: selectableCocktailList)
    }
}

//MARK: - Select & Deselect Cocktail
extension DefaultTriedCocktailSelectionViewModel {
    func selectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        filteredSelectableCocktailList[index].isSelected = true
        if let selectedCocktailIndex = selectableCocktailList.firstIndex(where: { $0.id == selectedID }) {
            selectableCocktailList[selectedCocktailIndex].isSelected = true
        }
    }
    
    func deselectCocktail(index: Int) {
        let selectedID = filteredSelectableCocktailList[index].id
        filteredSelectableCocktailList[index].isSelected = false
        if let selectedCocktailIndex = selectableCocktailList.firstIndex(where: { $0.id == selectedID }) {
            selectableCocktailList[selectedCocktailIndex].isSelected = false
        }
    }
}

//MARK: - Add TriedCocktail
extension DefaultTriedCocktailSelectionViewModel {
    func checkCocktailSelected() -> Bool {
        let result = selectableCocktailList.contains { $0.isSelected == true }
        
        return result
    }
    
    func addTriedCocktailList(completion: @escaping () -> Void) {
        let selectedCocktailList = makeSelectedCocktailIDList()
        
        addTriedCocktailUsecase.addTriedCocktails(cocktailID: selectedCocktailList)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { print("\($0)") },
                  receiveValue: {
                print($0)
                completion()
            }).store(in: &cancelBag)
    }
    
    func makeSelectedCocktailIDList() -> [Int] {
        let selectedCocktailIdList = selectableCocktailList.filter { $0.isSelected == true }.map { $0.id }
        
        return selectedCocktailIdList
    }
}
