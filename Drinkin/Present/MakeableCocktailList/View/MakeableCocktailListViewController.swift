//
//  MakeableCocktailListViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/10/26.
//

import UIKit
import SnapKit
import Combine

final class MakeableCocktailListViewController: UIViewController {
    private let viewModel: MakeableCocktailListViewModel
    var flowDelegate: MakeableCocktailListVCFlow?
    private var cancelBag: Set<AnyCancellable> = []
    private var makeableCocktailListDataSource: UICollectionViewDiffableDataSource<Section, MakeableCocktail>!
    
    private lazy var makeableCocktailCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCompositionalLayout())
        collectionView.register(MakeableCocktailCell.self, forCellWithReuseIdentifier: MakeableCocktailCell.identifier)
        
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
        configureMakeableCocktailCollectionView()
        configureDataSource()
        binding()
        viewModel.fetchMakeableCocktailList()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "만들 수 있는 칵테일 목록"
    }
    
    private func configureUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = .white
        
        view.addSubview(makeableCocktailCollectionView)
        
        makeableCocktailCollectionView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func configureMakeableCocktailCollectionView() {
        makeableCocktailCollectionView.delegate = self
    }
}

//MARK: - Delegate
extension MakeableCocktailListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cocktailID = viewModel.makeableCocktailList[indexPath.row].id
        
        flowDelegate?.pushProductDetailVC(cocktailID: cocktailID)
        
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

//MARK: - DiffableDataSource
extension MakeableCocktailListViewController {
    private func configureDataSource() {
        makeableCocktailListDataSource = UICollectionViewDiffableDataSource<Section,MakeableCocktail> (collectionView: makeableCocktailCollectionView) { (collectionView, indexPath, makeableCocktail) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MakeableCocktailCell.identifier, for: indexPath) as? MakeableCocktailCell else { return nil }
            
            cell.fill(with: makeableCocktail)
            
            return cell
        }
    }
    
    private func applySnapshot(makeableCocktailList: [MakeableCocktail]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MakeableCocktail>()
        snapshot.appendSections([.main])
        snapshot.appendItems(makeableCocktailList)
        makeableCocktailListDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Binding
extension MakeableCocktailListViewController {
    private func binding() {
        viewModel.makeableCocktailListPublisher.receive(on: RunLoop.main).sink { [weak self] in
            guard let self = self else { return }
            
            self.applySnapshot(makeableCocktailList: $0)
        }.store(in: &cancelBag)
    }
}
