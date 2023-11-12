//
//  MakeableCocktailListViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/26.
//

import UIKit
import SnapKit

final class MakeableCocktailListViewController: UIViewController {
    private let viewModel: MakeableCocktailListViewModel
    var delegate: MakeableCocktailListVCFlow?
    
    private lazy var cocktailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        
        return collectionView
    }()
    
    init(viewModel: MakeableCocktailListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
        
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "만들 수 있는 칵테일 목록"
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(cocktailCollectionView)
        
        cocktailCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }
}


//MARK: - CocktailCollectionView Compostional Layout
extension MakeableCocktailListViewController {
    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
