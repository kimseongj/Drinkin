//
//  AddItemViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit
import Combine

final class AddItemViewController: UIViewController {
    private var viewModel: AddIngredientViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private var filterDataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var itemDataSource: UICollectionViewDiffableDataSource<Section, ItemPreview>!
    
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
        
        return collectionView
    }()
    
    init(viewModel: AddIngredientViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureBackgroundColor()
        configureUI()
        configureFilterCollectionView()
        configureItemCollectionView()
        configureItemFilterDataSource()
        configureItemDataSource()
        filterBinding()
        itemBinding()
        viewModel.fetchItemFilter()
        viewModel.fetchItemList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.fetchSelectedItemList()
        viewModel.addSelectedItems(completion: {
            
        })
    }
    
    private func configureTitle() {
        self.title = "재료 추가하기"
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(itemFilterCollectionView)
        view.addSubview(itemCollectionView)
        
        itemFilterCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(20)
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
    }
    
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

//MARK: - FilterCollectionView ItemCollectionView Delegate
extension AddItemViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == itemFilterCollectionView {
            viewModel.filterItems(itemCategory: (viewModel.itemFilterList[indexPath.row]))
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

//MARK: - ItemFilterCollectionView DiffableDataSource
extension AddItemViewController {
    private func configureItemFilterDataSource() {
        filterDataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: itemFilterCollectionView) { collectionView, indexPath, itemFilter in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemFilterCell.identifier, for: indexPath) as? ItemFilterCell else { return UICollectionViewCell() }
            
            if itemFilter == "전체" {
//                self.itemFilterCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            }
            
            cell.fill(with: itemFilter)
            
            return cell
        }
    }
    
    private func applyItemFilterSnapshot(itemFilterList: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(itemFilterList)
        self.filterDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - ItemCollectionView DiffableDataSource
extension AddItemViewController {
    private func configureItemDataSource() {
        itemDataSource = UICollectionViewDiffableDataSource<Section, ItemPreview> (collectionView: itemCollectionView) { [weak self] (collectionView, indexPath, itemPreview) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.identifier, for: indexPath) as? ItemCell, let self = self else { return UICollectionViewCell() }
        
            
            if itemPreview.hold == true {
                cell.presentHoldItem()
                self.itemCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            } else {
                cell.presentUnholdItem()
                self.itemCollectionView.deselectItem(at: indexPath, animated: true)
            }
            
            cell.fill(with: itemPreview)
            
            return cell
        }
    }
    
    private func applyItemSnapshot(itemPreviewList: [ItemPreview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemPreview>()
        snapshot.appendSections([.main])
        snapshot.appendItems(itemPreviewList)
        self.itemDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension AddItemViewController {
    private func itemBinding() {
        viewModel.filteredItemListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applyItemSnapshot(itemPreviewList: $0)
        }.store(in: &cancelBag)
    }
    
    private func filterBinding() {
        viewModel.itemFilterPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applyItemFilterSnapshot(itemFilterList: $0)
        }.store(in: &cancelBag)
    }
}


//MARK: - ItemCollectionView Compositional Layout
extension AddItemViewController {
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
