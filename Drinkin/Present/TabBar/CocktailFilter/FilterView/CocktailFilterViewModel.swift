import Foundation
import Combine

protocol CocktailFilterViewModel {
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { get }
    var detailFilter: CocktailFilter? { get }
    var selectedDetailFilterIndexPath: IndexPath? { get set }
    var filterTypeList: [FilterType] { get }
    var textFilterTypeListPublisher: Published<[String]>.Publisher { get }
    var textFilterTypeList: [String] { get }
    
    
    func fetchCocktailList()
    func fetchCocktailFilter()
    func fetchDetailFilter(filterType: FilterType) -> [String]
    func insertDetailFilter(filterType: FilterType, detailFilterIndex: Int)
    func clearAllFilter()
}

final class DefaultCocktailFilterViewModel: CocktailFilterViewModel {
    private let fetchCocktailFilterUsecase: FetchCocktailFilterUsecase
    private let filterCocktailListUsecase: FilterCocktailListUsecase
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var filteredCocktailList: [PreviewDescription] = []
    
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { $filteredCocktailList }
    
    var detailFilter: CocktailFilter? = nil
    
    var selectedDetailFilterIndexPath: IndexPath?
    
    var filterTypeList: [FilterType] = [FilterType.category,
                                        FilterType.holdIngredient,
                                        FilterType.level,
                                        FilterType.abv,
                                        FilterType.sugarContent,
                                        FilterType.ingredientQuantity]
    
    @Published var textFilterTypeList: [String] = [FilterType.category.descriptionko,
                                                   FilterType.holdIngredient.descriptionko,
                                                   FilterType.level.descriptionko,
                                                   FilterType.abv.descriptionko,
                                                   FilterType.sugarContent.descriptionko,
                                                   FilterType.ingredientQuantity.descriptionko]
    
    var textFilterTypeListPublisher: Published<[String]>.Publisher { $textFilterTypeList }
    
    init(fetchCocktailFilterUsecase: FetchCocktailFilterUsecase,
         filterCocktailListUsecase: FilterCocktailListUsecase) {
        self.fetchCocktailFilterUsecase = fetchCocktailFilterUsecase
        self.filterCocktailListUsecase = filterCocktailListUsecase
    }
    
    func fetchCocktailList() {
        filterCocktailListUsecase.fetchCocktailList().sink(receiveCompletion: {
            print("\($0)")}, receiveValue: {
                self.filteredCocktailList = $0.cocktailList
            }).store(in: &cancelBag)
    }
    
    func fetchCocktailFilter() {
        fetchCocktailFilterUsecase.execute().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.detailFilter = $0
        }).store(in: &cancelBag)
    }
    
    func fetchDetailFilter(filterType: FilterType) -> [String] {
        guard let detailFilter = detailFilter else { return [] }
        
        switch filterType {
        case FilterType.category:
            return detailFilter.category
        case .holdIngredient:
            return detailFilter.holdIngredient
        case .level:
            return detailFilter.level
        case .abv:
            return detailFilter.abv
        case .sugarContent:
            return detailFilter.sugarContent
        case .ingredientQuantity:
            return detailFilter.ingredientQuantity
        }
    }
    
    func insertDetailFilter(filterType: FilterType, detailFilterIndex: Int) {
        if let index = filterTypeList.firstIndex(of: filterType) {
            if fetchDetailFilter(filterType: filterType)[detailFilterIndex] == "필터 해제" {
                textFilterTypeList[index] = filterTypeList[index].descriptionko
                clearFilter(index: index)
            } else {
                textFilterTypeList[index] = fetchDetailFilter(filterType: filterType)[detailFilterIndex]
                filterCocktail(filterType: filterTypeList[index].queryDescription, filter: textFilterTypeList[index])
            }
        }
    }
    
    func filterCocktail(filterType: String, filter: String) {
        filterCocktailListUsecase.addFilter(queryParameter: filterType, queryValue: filter)
        fetchCocktailList()
    }
    
    func clearFilter(index: Int) {
        filterCocktailListUsecase.clearFilter(queryParameter: filterTypeList[index].queryDescription)
    }

    func clearAllFilter() {
        for (index, _) in textFilterTypeList.enumerated() {
            textFilterTypeList[index] = filterTypeList[index].descriptionko
            filterCocktailListUsecase.clearAllFilter()
        }
        fetchCocktailList()
    }
}
