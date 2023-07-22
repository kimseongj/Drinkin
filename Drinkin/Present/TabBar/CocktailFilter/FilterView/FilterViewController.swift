//
//  FilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit
import SnapKit
import Combine

class FilterViewController: UIViewController {
    private enum Section: CaseIterable {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, FilteredItem>!
    
    private var cancelBag: Set<AnyCancellable> = []
    
    private let filterViewModel = FilterViewModel()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "칵테일 리스트"
        label.font = UIFont(name: "RixYeoljeongdo_Pro Regular", size: 20)
        
        return label
    }()
    
    private let initializationButton: UIButton = {
        let button = UIButton()
        button.setTitle("필터 초기화", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    private let selectionFilterView = SelectionFilterView()
    
    private lazy var filteredCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        bindFilteredItem()
        configureUI()
        filterViewModel.filteredItems = [FilteredItem(title: "갓파파더", levelGrade: 2, sugarContentGrade: 1, abvGrade: 3, ingredientQuantity: 2), FilteredItem(title: "갓파더", levelGrade: 2, sugarContentGrade: 1, abvGrade: 3, ingredientQuantity: 2)]
    }
    
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(initializationButton)
        view.addSubview(selectionFilterView)
        view.addSubview(filteredCollectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading).offset(16)
        }
        
        initializationButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-16)
        }
        
        selectionFilterView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        filteredCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectionFilterView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-AppCoordinator.tabBarHeight)
        }
    }
    
    private func bindFilteredItem() {
        filterViewModel.$filteredItems.sink {
            self.applySnapshot(filteredItems: $0)
        }.store(in: &cancelBag)
    }
    
    private func applySnapshot(filteredItems: [FilteredItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FilteredItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension FilterViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FilteredItem> (collectionView: filteredCollectionView) { collectionView, indexPath, filteredItem in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.configureCell(filteredItem: filteredItem)
            
            return cell
        }
    }
    
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
