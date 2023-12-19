//
//  ItemSelectionViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit
import Combine

final class ItemSelectionViewController: UIViewController {
    private var viewModel: ItemSelectionViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private var filterDataSource: UICollectionViewDiffableDataSource<Section, ItemFilter>!
    private var itemDataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var synchronizationDataDelegate: SyncDataDelegate?
    
    private let searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.placeholder = "재료 검색하기"
        
        return searchBar
    }()
    
    private let itemFilterCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(ItemFilterCell.self, forCellWithReuseIdentifier: ItemFilterCell.identifier)
    
        return collectionView
    }()
    
    private lazy var itemCollectionView: UICollectionView = {
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.allowsMultipleSelection = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.identifier)
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    
    private let updateView = UpdateView()
    
    //MARK: - Init
    
    init(viewModel: ItemSelectionViewModel) {
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
        itemBinding()
        errorBinding()
        configureItemFilterDataSource()
        configureItemDataSource()
        configureTitle()
        configureUI()
        configureBackBarButton()
        showActivityIndicator()
        configureFilterCollectionView()
        configureItemCollectionView()
        configureSearchBarDelegate()
    }
    
    //MARK: - Fetch Data
    
    private func fetchData() {
        viewModel.fetchItemData() {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideActivityIndicator()
            }
        }
    }
    
    //MARK: - ConfigureUI
    
    private func configureTitle() {
        self.title = "재료 추가하기"
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(searchBar)
        view.addSubview(itemFilterCollectionView)
        view.addSubview(itemCollectionView)
        view.addSubview(updateView)
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        itemFilterCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        itemCollectionView.snp.makeConstraints {
            $0.top.equalTo(itemFilterCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
        
        updateView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        updateView.isHidden = true
    }
    
    private func configureBackBarButton() {
        let backButton = UIBarButtonItem(image: ImageStorage.backIcon, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func backButtonTapped() {
        viewModel.fetchSelectedItemList()
        if viewModel.isSelectedItemChange() {
            updateView.isHidden = false
            updateView.startAnimating()
            viewModel.addSelectedItems { [weak self] in
                guard let self = self else { return }
                self.viewModel.makeDataChangedStatusTrue()
                self.updateView.isHidden = true
                self.synchronizationDataDelegate?.synchronizationHoldedItem()
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - SearchBar Delegate

extension ItemSelectionViewController: UISearchBarDelegate {
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
        viewModel.searchItem(text: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.searchItem(text: "")
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
    }
    
    func stopSearchBar() {
        searchBarCancelButtonClicked(searchBar)
    }
}

//MARK: - ConfigureCollectionView

extension ItemSelectionViewController {
    private func configureFilterCollectionView() {
        itemFilterCollectionView.delegate = self
        
        if let flowLayout = itemFilterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    private func configureItemCollectionView() {
        itemCollectionView.delegate = self
    }
}

//MARK: - ItemFilterCollectionView DiffableDataSource

extension ItemSelectionViewController {
    private func configureItemFilterDataSource() {
        filterDataSource = UICollectionViewDiffableDataSource<Section, ItemFilter> (collectionView: itemFilterCollectionView) { collectionView, indexPath, itemFilter in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemFilterCell.identifier, for: indexPath) as? ItemFilterCell else { return UICollectionViewCell() }
            
            cell.fill(with: itemFilter.name)
            
            return cell
        }
    }
    
    private func applyItemFilterSnapshot(itemFilterList: [ItemFilter]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemFilter>()
        snapshot.appendSections([.main])
        snapshot.appendItems(itemFilterList)
        self.filterDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - ItemCollectionView DiffableDataSource

extension ItemSelectionViewController {
    private func configureItemDataSource() {
        itemDataSource = UICollectionViewDiffableDataSource<Section, Item> (collectionView: itemCollectionView) { [weak self] (collectionView, indexPath, item) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell, let self = self else { return UICollectionViewCell() }
            
            if item.hold == true {
                cell.presentHoldItem()
                self.itemCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            } else {
                cell.presentUnholdItem()
                self.itemCollectionView.deselectItem(at: indexPath, animated: true)
            }
            
            cell.fill(with: item)
            
            return cell
        }
    }
    
    private func applyItemSnapshot(itemList: [Item]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(itemList)
        self.itemDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding

extension ItemSelectionViewController {
    private func itemBinding() {
        viewModel.filteredItemListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applyItemSnapshot(itemList: $0)
        }.store(in: &cancelBag)
    }
    
    private func filterBinding() {
        viewModel.itemFilterPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applyItemFilterSnapshot(itemFilterList: $0)
            self.itemFilterCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        }.store(in: &cancelBag)
    }
}


//MARK: - ItemCollectionView Compositional Layout

extension ItemSelectionViewController {
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(84))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

//MARK: - FilterCollectionView ItemCollectionView Delegate

extension ItemSelectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemFilterCollectionView {
            viewModel.filterItems(itemCategory: (viewModel.itemFilterList[indexPath.row].subType))
            stopSearchBar()
        } else {
            if let cell = itemCollectionView.cellForItem(at: indexPath) as? ItemCell {
                cell.presentHoldItem()
                viewModel.selectItem(index: indexPath.row)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == itemCollectionView {
            guard let cell = itemCollectionView.cellForItem(at: indexPath) as? ItemCell else { return }
            
            cell.presentUnholdItem()
            viewModel.deselectItem(index: indexPath.row)
        }
    }
}

//MARK: - Handling Error

extension ItemSelectionViewController {
    func errorBinding() {
        viewModel.errorHandlingPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.handlingError(errorType: $0)
            }).store(in: &cancelBag)
    }
}
