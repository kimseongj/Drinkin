//
//  UserMadeCocktailListViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/11.
//

import UIKit
import SnapKit
import Combine

final class UserMadeCocktailListViewController: UIViewController {
    private var viewModel: UserMadeCocktailListViewModel
    private var cancelBag: Set<AnyCancellable> = []
    private var dataSource: UICollectionViewDiffableDataSource<Section, CocktailPreview>!
    
    private lazy var cocktailListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FilteredCocktailCell.self, forCellWithReuseIdentifier: FilteredCocktailCell.identifier)
        
        return collectionView
    }()
    
    
    init(viewModel: UserMadeCocktailListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundColor()
        configureNavigationItemTitle()
        configureUI()
        configureDataSource()
        binding()
        viewModel.fetchCocktailPreviewDescription()
    }
    
    private func configureBackgroundColor() {
        view.backgroundColor = .white
    }
    
    private func configureNavigationItemTitle() {
        self.navigationItem.title = "내가 만든 칵테일 목록"
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.addSubview(cocktailListCollectionView)
        
        cocktailListCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
    }
}

//MARK: - CocktailListCollectionView DiffableDataSource
extension UserMadeCocktailListViewController {
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, CocktailPreview> (collectionView: cocktailListCollectionView) { collectionView, indexPath, previewDescription in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredCocktailCell.identifier, for: indexPath) as? FilteredCocktailCell else { return nil }
            
            cell.fill(with: previewDescription)
            
            return cell
        }
    }
    
    private func applySnapshot(previewDescriptionList: [CocktailPreview]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CocktailPreview>()
        snapshot.appendSections([.main])
        snapshot.appendItems(previewDescriptionList)
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension UserMadeCocktailListViewController {
    private func binding() {
        viewModel.previewDescriptionListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            self.applySnapshot(previewDescriptionList: $0)
        }.store(in: &cancelBag)
    }
}

//MARK: - CocktailListCollectionView Compositional Layout
extension UserMadeCocktailListViewController {
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
