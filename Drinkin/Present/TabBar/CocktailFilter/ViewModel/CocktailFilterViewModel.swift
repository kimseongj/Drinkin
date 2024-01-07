import Foundation
import Combine

protocol CocktailFilterViewModelOutput {
    var errorHandlingPublisher: Published<APIError>.Publisher { get }
    var filteredCocktailList: [CocktailPreview] { get set }
    var filteredCocktailListPublisher: Published<[CocktailPreview]>.Publisher { get }
    var textFilterTypeList: [String] { get }
    var textFilterTypeListPublisher: Published<[String]>.Publisher { get }
    var filterTypeList: [FilterType] { get }
    var detailFilter: CocktailFilter? { get }
    var selectedDetailFilterIndexPath: IndexPath? { get set }
    var isAuthenticated: Bool { get set }
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never>
}

protocol CocktailFilterViewModelInput {
    func fetchCocktailList(completion: @escaping () -> Void)
    func fetchCocktailFilter(completion: @escaping () -> Void)
    func fetchDetailFilter(filterType: FilterType) -> [String]
    func insertDetailFilter(filterType: FilterType, detailFilterIndex: Int)
    func clearAllFilter()
    func searchCocktail(text: String)
}

typealias CocktailFilterViewModel = CocktailFilterViewModelOutput & CocktailFilterViewModelInput

final class DefaultCocktailFilterViewModel: CocktailFilterViewModel {
    private let cocktailFilterRepository: CocktailFilterRepository
    private let filterCocktailListUsecase: FilterCocktailListUsecase
    private let authenticationManager: AuthenticationManager
    private var cancelBag: Set<AnyCancellable> = []
    
    @Published var errorType: APIError = APIError.noError
    
    var currentFilteredCocktailList: [CocktailPreview] = []
    
    //MARK: - Init
    
    init(cocktailFilterRepository: CocktailFilterRepository,
         filterCocktailListUsecase: FilterCocktailListUsecase,
         authenticationManager: AuthenticationManager) {
        self.cocktailFilterRepository = cocktailFilterRepository
        self.filterCocktailListUsecase = filterCocktailListUsecase
        self.authenticationManager = authenticationManager
    }
    
    //MARK: - Output
    
    var errorHandlingPublisher: Published<APIError>.Publisher { $errorType }
    @Published var filteredCocktailList: [CocktailPreview] = []
    var filteredCocktailListPublisher: Published<[CocktailPreview]>.Publisher { $filteredCocktailList }
    @Published var textFilterTypeList: [String] = [FilterType.category.descriptionko,
                                                   FilterType.level.descriptionko,
                                                   FilterType.abv.descriptionko,
                                                   FilterType.sugarContent.descriptionko,
                                                   FilterType.ingredientQuantity.descriptionko]
    var textFilterTypeListPublisher: Published<[String]>.Publisher { $textFilterTypeList }
    var filterTypeList: [FilterType] = [FilterType.category,
                                        FilterType.level,
                                        FilterType.abv,
                                        FilterType.sugarContent,
                                        FilterType.ingredientQuantity]
    var detailFilter: CocktailFilter? = nil
    var selectedDetailFilterIndexPath: IndexPath?
    
    var isAuthenticated: Bool = false
    
    func accessTokenStatusPublisher() -> AnyPublisher<Bool, Never> {
        return authenticationManager.accessTokenStatusPublisher()
    }
}


//MARK: - Input
//MARK: - Fetch Data

enum ErrorHandling {
    case normal
    case unauthorized
    case notFound
    case networkError
    case docodingError
    case refreshTokenExpired
}

extension DefaultCocktailFilterViewModel {
    func fetchCocktailList(completion: @escaping () -> Void) {
        filterCocktailListUsecase.fetchCocktailList()
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
                    self.filteredCocktailList = $0.cocktailList.sorted(by: {$0.cocktailNameKo < $1.cocktailNameKo})
                    self.currentFilteredCocktailList = self.filteredCocktailList
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    func fetchCocktailFilter(completion: @escaping () -> Void) {
        cocktailFilterRepository.fetchCocktailFilter()
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
                receiveValue: { [weak self] in
                    guard let self = self else { return }
                    
                    self.detailFilter = $0
                    completion()
                }
            ).store(in: &cancelBag)
    }
    
    func fetchDetailFilter(filterType: FilterType) -> [String] {
        guard let detailFilter = detailFilter else { return [] }
        
        switch filterType {
        case FilterType.category:
            return detailFilter.category
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
}

//MARK: - Filter Cocktail

extension DefaultCocktailFilterViewModel {
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
        fetchCocktailList { }
    }
    
    func clearFilter(index: Int) {
        filterCocktailListUsecase.clearFilter(queryParameter: filterTypeList[index].queryDescription)
        fetchCocktailList { }
    }
    
    func clearAllFilter() {
        for (index, _) in textFilterTypeList.enumerated() {
            textFilterTypeList[index] = filterTypeList[index].descriptionko
        }
        
        filterCocktailListUsecase.clearAllFilter()
        fetchCocktailList { }
    }
    
    func searchCocktail(text: String) {
        filteredCocktailList = currentFilteredCocktailList.filter {
            $0.cocktailNameKo.localizedStandardContains(text)
        }
        
        if text == "" {
            filteredCocktailList = currentFilteredCocktailList
        }
    }
}
