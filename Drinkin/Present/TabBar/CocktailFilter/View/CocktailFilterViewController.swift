//
//  CocktailFilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit
import SnapKit
import Combine

final class CocktailFilterViewController: UIViewController {
    private var viewModel: CocktailFilterViewModel
    var flowDelegate: CocktailFilterVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    private var filterDataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var cocktailDataSource: UICollectionViewDiffableDataSource<Section, CocktailPreview>!
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 리스트"
        label.font = UIFont(name: FontStrings.themeFont, size: 20)
        
        return label
    }()
    
    private lazy var resetFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("필터 초기화", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(tapResetFilterButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    private func tapResetFilterButton() {
        let resetFilterPopupViewController = ResetFilterPopupViewController()
        resetFilterPopupViewController.delegate = self
        resetFilterPopupViewController.modalPresentationStyle = .formSheet
        present(resetFilterPopupViewController, animated: true)
    }
    
    private let searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.placeholder = "칵테일 검색하기"
        
        return searchBar
    }()
    
    
    private let filterSelectionCollectionView: UICollectionView =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(FilterSelectionCell.self, forCellWithReuseIdentifier: FilterSelectionCell.identifier)
        
        return collectionView
    }()
    
    private lazy var filteredCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    //MARK: - Init
    
    init(viewModel: CocktailFilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        filterBinding()
        cocktailBinding()
        errorBinding()
        configureFilterDataSource()
        configureCocktailDataSource()
        configureUI()
        showActivityIndicator()
        configureFilterSelectionCollectionView()
        configureFilteredCollectionView()
        makeSelectionFilterCollectionViewDisable()
        configureSearchBarDelegate()
        authenticationBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppCoordinator.tabBarController.tabBar.isHidden = false
    }
    
    //MARK: - Fetch Data
    
    private func fetchData() {
        viewModel.fetchCocktailList() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideActivityIndicator()
            }
        }
        
        viewModel.fetchCocktailFilter { [weak self] in
            guard let self = self else { return }
            self.makeSelectionFilterCollectionViewEnable()
        }
    }
    
    //MARK: - ConfigureUI
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(titleLabel)
        view.addSubview(resetFilterButton)
        view.addSubview(searchBar)
        view.addSubview(filterSelectionCollectionView)
        view.addSubview(filteredCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        resetFilterButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        filterSelectionCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        filteredCollectionView.snp.makeConstraints {
            $0.top.equalTo(filterSelectionCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
}

//MARK: - ResetDelegate

extension CocktailFilterViewController: ResetFilterDelegate {
    func resetFilter() {
        viewModel.clearAllFilter()
    }
}

//MARK: - SearchBarDelegate

extension CocktailFilterViewController: UISearchBarDelegate {
    func configureSearchBarDelegate() {
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.layer.borderColor = ColorPalette.themeColor.cgColor
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        viewModel.searchCocktail(text: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.searchCocktail(text: "")
        dismissKeyboard()
        searchBar.showsCancelButton = false
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.layer.borderColor = ColorPalette.buttonBorderColor
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.layer.borderColor = ColorPalette.buttonBorderColor
        }
    }
    
    func stopSearchBar() {
        searchBarCancelButtonClicked(searchBar)
    }
}

//MARK: - StopSearchBarDelegate

protocol StopSearchBarDelegate {
    func stopSearchBar()
}

extension CocktailFilterViewController: StopSearchBarDelegate { }

//MARK: - ConfigureCollectionView

extension CocktailFilterViewController {
    private func configureFilterSelectionCollectionView() {
        filterSelectionCollectionView.delegate = self
        
        if let flowLayout = filterSelectionCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func configureFilteredCollectionView() {
        filteredCollectionView.delegate = self
    }
    
    private func makeSelectionFilterCollectionViewDisable() {
        filterSelectionCollectionView.isUserInteractionEnabled = false
    }
    
    private func makeSelectionFilterCollectionViewEnable() {
        filterSelectionCollectionView.isUserInteractionEnabled = true
    }
}

//MARK: - FilterSelectionCollectionView DiffableDataSource

extension CocktailFilterViewController {
    private func configureFilterDataSource() {
        filterDataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: filterSelectionCollectionView) { (collectionView, indexPath, categoryName) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterSelectionCell.identifier, for: indexPath) as? FilterSelectionCell else { return UICollectionViewCell() }
            
            cell.fill(with: categoryName)
            
            if self.viewModel.textFilterTypeList[indexPath.row] != self.viewModel.filterTypeList[indexPath.row].descriptionko && self.viewModel.filterTypeList[indexPath.row] != FilterType.category {
                cell.makeFixedCell()
            } else {
                cell.makeDefaultCell()
            }
            
            if self.viewModel.filterTypeList[indexPath.row] == FilterType.category {
                cell.makeBlackCell()
            }
            
            return cell
        }
    }
    
    private func applyFilterSnapshot(filterList: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filterList)
        self.filterDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - FilteredCollectionView DiffableDataSource

extension CocktailFilterViewController {
    private func configureCocktailDataSource() {
        cocktailDataSource = UICollectionViewDiffableDataSource<Section, CocktailPreview> (collectionView: filteredCollectionView) { collectionView, indexPath, filteredItem in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.fill(with: filteredItem)
            
            return cell
        }
    }
    
    private func applyCocktailSnapshot(filteredItems: [CocktailPreview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailPreview>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        self.cocktailDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding

extension CocktailFilterViewController {
    private func filterBinding() {
        viewModel.textFilterTypeListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            self.applyFilterSnapshot(filterList: $0)
        }.store(in: &cancelBag)
    }
}

extension CocktailFilterViewController {
    private func cocktailBinding() {
        viewModel.filteredCocktailListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            self.applyCocktailSnapshot(filteredItems: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - FilteredCocktailCollectionView Compositional Layout

extension CocktailFilterViewController {
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

//MARK: - FilteredCollectionView, FilterSelectionCollectionView Delegate

extension CocktailFilterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterSelectionCollectionView {
                dismissKeyboard()
                let cocktailFilterModalViewController = CocktailFilterModalViewController(filterType: viewModel.filterTypeList[indexPath.row], viewModel: viewModel, stopSearchBarDelegate: self)
                cocktailFilterModalViewController.modalPresentationStyle = .overFullScreen
                present(cocktailFilterModalViewController, animated: false)
        } else {
            dismissKeyboard()
            let cocktailID = viewModel.filteredCocktailList[indexPath.row].id
            flowDelegate?.pushProductDetailVCCoordinator(cocktailID: cocktailID)
        }
    }
}

//MARK: - Handling Error

extension CocktailFilterViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}

//MARK: - Authentication Binding

extension CocktailFilterViewController {
    func authenticationBinding() {
        viewModel.accessTokenStatusPublisher().receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            if $0 == true {
                self.viewModel.isAuthenticated = true
            }  else {
                self.viewModel.isAuthenticated = false
            }
        }.store(in: &cancelBag)
    }
}
