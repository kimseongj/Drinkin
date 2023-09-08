//
//  CocktailListViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/08.
//

import Foundation

import UIKit
import SnapKit
import Combine

final class CocktailListViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, FilteredItem>!
    
    private lazy var cocktailListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItemTitle()
        configureUI()
    }
    
    private func configureNavigationItemTitle() {
        self.navigationItem.title = "저장한 칵테일 목록"
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(cocktailListCollectionView)
        
        cocktailListCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
    }
}

//MARK: - CocktailListCollectionView DiffableDataSource
extension CocktailListViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FilteredItem> (collectionView: cocktailListCollectionView) { collectionView, indexPath, filteredItem in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.fill(with: filteredItem)
            
            return cell
        }
    }
    
    private func applySnapshot(filteredItems: [FilteredItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FilteredItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - CocktailListCollectionView Compositional Layout
extension CocktailListViewController {
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
