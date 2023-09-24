//
//  AddIngredientViewCotroller.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/22.
//

import UIKit
import SnapKit
import Combine

final class AddIngredientViewCotroller: UIViewController {
    private var viewModel: AddIngredientViewModel?
    
    private var filterDataSource: UICollectionViewDiffableDataSource<Section, String>!
    private var ingredientDataSource: UICollectionViewDiffableDataSource<Section, IngredientDescription>!
    
    private let ingredientFilterCollectionView: UICollectionView = {
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
    
    private lazy var ingredientCollectionView: UICollectionView = {
        let  collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    init(viewModel: AddIngredientViewModel?) {
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
        
    }
    
    private func configureTitle() {
        self.title = "재료 추가하기"
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(ingredientFilterCollectionView)
        view.addSubview(ingredientCollectionView)
        
        ingredientFilterCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(60)
        }
        
        ingredientCollectionView.snp.makeConstraints {
            $0.top.equalTo(ingredientFilterCollectionView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
    }
    
    private func configureFilterCollectionView() {
        ingredientFilterCollectionView.delegate = self
    
        if let flowLayout = ingredientFilterCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

//MARK: - FilterCollectionView DiffableDataSource
extension AddIngredientViewCotroller {
    private func configureFilterDataSource() {
        filterDataSource = UICollectionViewDiffableDataSource<Section, String> (collectionView: ingredientFilterCollectionView) { collectionView, indexPath, ingredientFilter in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientFilterCell.identifier, for: indexPath) as? IngredientFilterCell else { return UICollectionViewCell() }
            
            cell.fill(with: ingredientFilter)
            
            return cell
        }
    }
    
    private func applyFilterSnapshot(filter: [String]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filter)
        self.filterDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

extension AddIngredientViewCotroller: UICollectionViewDelegate {
    
}

//MARK: - IngredientCollectionView Compositional Layout
extension AddIngredientViewCotroller {
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(84))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
