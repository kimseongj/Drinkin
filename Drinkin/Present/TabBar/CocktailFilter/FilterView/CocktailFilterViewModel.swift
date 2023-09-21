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
    func fetchCocktailFilter(completion: @escaping () -> Void)
    func fetchDetailFilter(filterType: FilterType) -> [String]
    func insertDetailFilter(filterType: FilterType, detailFilterIndex: Int)
}

final class DefaultCocktailFilterViewModel: CocktailFilterViewModel {
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var filteredCocktailList: [PreviewDescription] = []
    
    var filteredCocktailListPublisher: Published<[PreviewDescription]>.Publisher { $filteredCocktailList }
    
    var detailFilter: CocktailFilter? = nil
    
    var selectedDetailFilterIndexPath: IndexPath?
    
    var filterTypeList: [FilterType] = [FilterType.categoryFilter,
                      FilterType.holdIngredientFilter,
                      FilterType.level,
                      FilterType.abv,
                      FilterType.sugarContent,
                      FilterType.ingredientQuantity]
    
    @Published var textFilterTypeList: [String] = [FilterType.categoryFilter.description,
                                        FilterType.holdIngredientFilter.description,
                                        FilterType.level.description,
                                        FilterType.abv.description,
                                        FilterType.sugarContent.description,
                                        FilterType.ingredientQuantity.description]
    
    var textFilterTypeListPublisher: Published<[String]>.Publisher { $textFilterTypeList }
    
    
    private let fetchCocktailFilterUsecase: FetchCocktailFilterUsecase
    private let fetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase
    
    init(fetchCocktailFilterUsecase: FetchCocktailFilterUsecase, fetchPreviewDescriptionUsecase: FetchPreviewDescriptionUsecase) {
        self.fetchCocktailFilterUsecase = fetchCocktailFilterUsecase
        self.fetchPreviewDescriptionUsecase = fetchPreviewDescriptionUsecase
    }
    
    func fetchCocktailList() {
        fetchPreviewDescriptionUsecase.execute().sink(receiveCompletion: {
            print("\($0)")}, receiveValue: {
                self.filteredCocktailList = $0.cocktailList
            }).store(in: &cancelBag)
    }
    
    func fetchCocktailFilter(completion: @escaping () -> Void) {
        fetchCocktailFilterUsecase.execute().receive(on: RunLoop.main).sink(receiveCompletion: { print("\($0)")}, receiveValue: {
            self.detailFilter = $0
            completion()
        }).store(in: &cancelBag)
    }
    
    func fetchDetailFilter(filterType: FilterType) -> [String] {
        guard let detailFilter = detailFilter else { return [] }
        
        switch filterType {
        case FilterType.categoryFilter:
            return detailFilter.category
        case .holdIngredientFilter:
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
                textFilterTypeList[index] = filterTypeList[index].description
            } else {
                textFilterTypeList[index] = fetchDetailFilter(filterType: filterType)[detailFilterIndex]
            }
            
        }
    }
}
